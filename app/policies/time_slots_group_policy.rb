class TimeSlotsGroupPolicy < ApplicationPolicy

  def create?
    @user.is_manager?
  end

end
