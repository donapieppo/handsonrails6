class Game < ApplicationRecord
  belongs_to :user
  belongs_to :color
  has_many :reactions

  has_one_attached :sketch

  def to_s
    self.name
  end

end
