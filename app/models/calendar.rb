class Calendar < ApplicationRecord
  has_many :calendars_disciplines
  has_many :disciplines, through: :calendars_disciplines
  has_many :time_slots
  has_many :time_slots_groups

  def to_s
    name
  end
end
