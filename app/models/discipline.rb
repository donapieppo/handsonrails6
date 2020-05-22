class Discipline < ApplicationRecord
  has_many :time_slots
  has_many :time_slots_groups

  def to_s
    name
  end
end
