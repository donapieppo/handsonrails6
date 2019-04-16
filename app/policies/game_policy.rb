class GamePolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def show?
    if @user and @user.is_manager?
      true
    else
      @record.show_to_anyone?
    end
  end

  def new?
    @user
  end

  def create?
    # of course ok if @user (in controller @game.user_id = current_user.id)
    @user and (@user.id == @record.user_id or @user.is_admin?)
  end

  def edit?
    @user and (@user.id == @record.user_id or @user.is_admin?)
  end

  def update?
    edit?
  end

  def destroy?
    edit?
  end
end
