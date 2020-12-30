class TimeSlotsGroup < ApplicationRecord
  has_many :time_slots
  belongs_to :calendar

  before_save :check_uniqueness,
              :check_single_day
  after_save :create_slots

  def to_s
    I18n.l(self.start_date) 
  end

  def check_uniqueness
    if TimeSlotsGroup.where('end_date > ? and start_date < ?', self.start_date, self.end_date).count > 0
      self.errors.add(:start_date, 'Interseca altri  range')
    end
  end

  def check_single_day
    if self.start_date.to_date != self.end_date.to_date
      self.errors.add(:start_date, 'Limita a un giorno il range')
    end
  end

  def create_slots
    n = 0
    while (s = self.start_date + (n * self.every_minutes).minutes) &&
          (e = self.start_date + (n * self.every_minutes + self.minutes).minutes) <= self.end_date
      ts = TimeSlot.create(time_slots_group_id: self.id,
                           calendar_id: self.calendar_id,
                           max_number: self.max_number,
                           start_date: s,
                           end_date: e) 
      p ts.inspect
      n = n + 1
    end
  end
end
