class GamePolicy < ApplicationPolicy
  def show?
    if @user and @user.is_manager?
      true
    else
      @record.show_to_anyone?
    end
  end

  def create?
    @user 
  end

  def update?
    @user && (@user.id == @record.user_id || @user.is_admin?)
  end

  def destroy?
    update?
  end

  def edit_pinnings?
    update?
  end

  def pinnings?
    update?
  end
end
