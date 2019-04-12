class User < ApplicationRecord
  has_many :games
  has_many :reactions
  has_many :comments

  def has_reactions?(game, what)
    self.reactions.where(game_id: (game.is_a?(Game) ? game.id : game), name: what).any?
  end

  def is_manager?
    self.manager
  end

  def is_admin?
    Rails.configuration.admins.include?(self.email)
  end
end
