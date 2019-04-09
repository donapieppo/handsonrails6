class Reaction < ApplicationRecord
  belongs_to :user
  belongs_to :game

  @@rtypes = [:like, :soft, :hard]

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

  def update_game_reactions_cache
    self.game.update_reactions_counts
  end
end

