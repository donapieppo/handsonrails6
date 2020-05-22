class TimeSlotPolicy < ApplicationPolicy
  def index?
    true
  end

  def create?
    @user.is_manager?
  end
end
