class TimeSlot < ApplicationRecord
  belongs_to :time_slots_group
  belongs_to :discipline
  has_many :bookings

  def to_s
    I18n.l(self.start_date) + "->" + I18n.l(self.end_date) + " ore " + self.start_date.hour.to_s + " - " + self.end_date.hour.to_s 
  end

  def free_places
    self.max_number - self.inetrsecated_bookings.count
  end

  def inetrsecated_bookings
    Booking.where(time_slot_id: self.inetrsecated_time_slots.ids)
  end

  def inetrsecated_time_slots
    TimeSlot.where('end_date > ? and start_date < ?', self.start_date, self.end_date)
  end

end

