class UserLimitValidator < ActiveModel::Validator
  def one_in_a_day
  end

  def validate(record)
    sb_n = record.same_day_bookings.where(user_id: record.user_id).count
    if (sb_n > 1) || (record.new_record? && sb_n > 0) 
      record.errors[:base] << 'Già prenotato oggi'
    end
  end
end

class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :time_slot

  validates_with UserLimitValidator
  
  scope :on_day, -> (d) { includes(:time_slot).where('DATE(time_slots.start_date) = ?', d.strftime("%Y-%m-%d")).references(:time_slot) }

  def to_s
    self.user.email
  end

  def same_day_bookings
    Booking.includes(:time_slot).where('time_slots.calendar_id = ?', self.time_slot.calendar_id).on_day(self.time_slot.start_date)
  end
end

