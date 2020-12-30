class CalendarsController < ApplicationController
  def index
    @calendars = Calendar.all
  end

end


