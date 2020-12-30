class TimeSlotsController < ApplicationController
  before_action :get_calendar

  def index
    @time_slots_groups = @calendar.time_slots_groups.includes(:time_slots)
    authorize :time_slot
  end

  private

  def get_calendar
    @calendar = Calendar.find(params[:calendar_id])
  end

end

