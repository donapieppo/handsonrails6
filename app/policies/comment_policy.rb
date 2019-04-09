class CommentPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def show?
    true
  end

  def new?
    @user
  end

  def create?
    @user
  end

  def edit?
    @user and @user.id == @record.user_id
  end

  def update?
    edit?
  end

  def destroy?
    @user and @user.id == @record.user_id
  end
end


