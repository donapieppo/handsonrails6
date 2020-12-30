class Discipline < ApplicationRecord
  has_many :calendars_disciplines
  has_many :calendars, through: :calendars_disciplines

  def to_s
    name
  end
end
