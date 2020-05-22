class TimeSlotsController < ApplicationController
  before_action :get_discipline

  def index
    @time_slots = @discipline.time_slots
    authorize :time_slot
  end

  def new
    @time_slot = TimeSlot.new
    authorize @time_slot
  end

  private

  def get_discipline
    @discipline = Discipline.find(params[:discipline_id])
  end

end

