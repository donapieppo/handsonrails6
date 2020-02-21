class CommentPolicy < ApplicationPolicy
  def show?
    true
  end

  def create?
    @user
  end

  def update?
    @user and @user.id == @record.user_id
  end

  def destroy?
    update?
  end
end


