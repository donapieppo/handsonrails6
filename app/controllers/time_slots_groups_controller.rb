class TimeSlotsGroupsController < ApplicationController
  before_action :get_discipline

  def new
    @time_slots_group = TimeSlotsGroup.new
    authorize @time_slots_group
  end

  def create
    @time_slots_group = @discipline.time_slots_groups.new(time_slots_group_params)
    if @time_slots_group.save
      redirect_to discipline_time_slots_path
    else
      render action: :new
    end
  end

  private

  def get_discipline
    @discipline = Discipline.find(params[:discipline_id])
  end

  def time_slots_group_params
    params[:time_slots_group].permit(:start_date, :end_date, :max_number, :minutes, :every_minutes)
  end
end

