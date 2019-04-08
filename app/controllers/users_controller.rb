class UsersController < ApplicationController
  before_action :user_admin!
  before_action :get_user, only: [:edit, :update, :destroy]

  def index
    @users = User.order(:name).all
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      redirect_to users_path
    else
      render action: :edit
    end
  end

  private

  def user_params
    params[:user].permit(:name, :email)
  end

  def get_user
    @user = User.find(params[:id])
  end
end
