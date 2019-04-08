class ApplicationController < ActionController::Base
  include Pundit

  I18n.locale = :it

  helper_method :current_user, :user_admin?, :user_admin!

  before_action :log_current_user

  def current_user
    if session[:user_id]
      @current_user ||= User.find(session[:user_id])
    else
      nil
    end
  end

  def log_current_user
    if current_user
      logger.info "Current user: #{current_user.email}" 
    end
  end

  def user_admin?
    current_user && Rails.configuration.admins.include?(current_user.email)
  end

  def user_admin!
    user_admin? or raise NotAllowed
  end
end
