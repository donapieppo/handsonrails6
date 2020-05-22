class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :time_slot

  def to_s
    self.user.email
  end

end

