class User < ApplicationRecord
  has_many :games
  has_many :reactions
  has_many :comments
  has_many :bookings

  validates :name, uniqueness: { case_sensitive: false }
  validates :email, uniqueness: { case_sensitive: false }

  def to_s
    self.name
  end

  # alternative witch cache to self.reactions.where(game_id: (game.is_a?(Game) ? game.id : game), name: what).any?
  def has_reactions?(game, what)
    game_id = game.is_a?(Game) ? game.id : game
    @_cache_my_reactions_to_game ||= {}
    @_cache_my_reactions_to_game[game_id] ||= self.reactions.where(game_id: game_id).map(&:name)
    @_cache_my_reactions_to_game[game_id].include?(what.to_s)
  end

  def is_manager?
    self.manager
  end

  def is_admin?
    Rails.configuration.admins.include?(self.email)
  end
end
