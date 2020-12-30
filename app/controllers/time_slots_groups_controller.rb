class TimeSlotsGroupsController < ApplicationController
  before_action :get_calendar, only: [:new, :create]

  def new
    @time_slots_group = @calendar.time_slots_groups.new
    authorize @time_slots_group
  end

  def create
    @time_slots_group = @calendar.time_slots_groups.new(time_slots_group_params)
    authorize @time_slots_group
    if @time_slots_group.save
      redirect_to calendar_time_slots_path
    else
      render action: :new
    end
  end

  def destroy
    tsg = TimeSlotsGroup.find(params[:id])
    authorize tsg
    tsg.destroy
    redirect_to disciplines_path
  end

  private

  def get_calendar
    @calendar = Calendar.find(params[:calendar_id])
  end

  def time_slots_group_params
    params[:time_slots_group].permit(:start_date, :end_date, :max_number, :minutes, :every_minutes)
  end
end

