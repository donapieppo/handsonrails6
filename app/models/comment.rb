class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :game

  def to_s
    self.name
  end
end

