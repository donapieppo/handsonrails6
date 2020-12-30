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
      flash[:notice] = "Registrazione corretta"
    else
      flash[:alert] = @booking.errors[:base]
    end
    redirect_to calendar_time_slots_path(@ts.calendar_id) and return
  end

  def destroy
    booking = Booking.find(params[:id])
    booking.delete
    redirect_to time_slot_bookings_path(booking.time_slot_id)
  end
end

