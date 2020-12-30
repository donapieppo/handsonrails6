class DisciplinesController < ApplicationController
  def index
    @disciplines = Discipline.where(id: CalendarsDiscipline.select(:discipline_id).map(&:discipline_id)).includes(:calendars)
  end
end

