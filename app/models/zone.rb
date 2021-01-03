class Zone < ApplicationRecord
  belongs_to :game

  def to_s
    self.name
  end
end

