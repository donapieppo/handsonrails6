class Color < ApplicationRecord
  validates :name, uniqueness: { case_sensitive: false }
  has_many :games
end
