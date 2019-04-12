class UsersController < ApplicationController
  before_action :user_admin!, except: [:myedit, :myupdate]
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

  def myedit
    if current_user
      @user = current_user
    else
      redirect_to root_path
    end
  end

  def myupdate
    if current_user
      current_user.update_attribute(:name, params[:new_name])
    end
    redirect_to root_path
  end

  private

  def user_params
    params[:user].permit(:name, :email, :manager)
  end

  def get_user
    @user = User.find(params[:id])
  end
end
