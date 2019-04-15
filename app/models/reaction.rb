class Reaction < ApplicationRecord
  belongs_to :user
  belongs_to :game

  @@rtypes = [:like, :hard, :soft, :working, :sent]

  before_save :check_hard_and_soft
  after_save :update_game_reactions_cache
  after_destroy :update_game_reactions_cache

  def self.permitted_reaction?(what)
    @@rtypes.include?(what.to_sym)
  end

  def self.each_types
    @@rtypes.each do |t|
      yield t
    end
  end

  def check_hard_and_soft
    if self.name == 'hard'
      Reaction.where(user_id: self.user_id, game_id: self.game.id, name: 'soft').destroy_all
    elsif self.name == 'soft'
      Reaction.where(user_id: self.user_id, game_id: self.game.id, name: 'hard').destroy_all
    end
  end

  def update_game_reactions_cache
    self.game.update_reactions_counts
  end
end

