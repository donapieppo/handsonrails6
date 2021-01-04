class Zone < ApplicationRecord
  belongs_to :game

  def to_s
    self.description + " (#{self.name})"
  end
end

