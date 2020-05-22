class BookingsController < ApplicationController

  def index
    @time_slot = TimeSlot.find(params[:time_slot_id])
    authorize :booking
    @bookings = @time_slot.bookings.includes(:user)
  end

  def new
    @ts = TimeSlot.find(params[:time_slot_id])
    @booking = current_user.bookings.new(time_slot_id: @ts.id)
    if @booking.save
      redirect_to discipline_time_slots_path(@ts.discipline_id) and return
    end
  end

  def destroy

  end
end

