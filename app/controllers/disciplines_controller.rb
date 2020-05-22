class DisciplinesController < ApplicationController
  def index
    @disciplines = Discipline.all
  end
end

