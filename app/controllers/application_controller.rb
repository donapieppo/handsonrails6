class ApplicationController < ActionController::Base
  include Pundit

  I18n.locale = :it

  helper_method :current_user, :current_organization, :user_admin?, :user_admin!, :user_manager?, :user_manager!, :modal_page?

  before_action :log_current_user

  def current_user
    if false or Rails.env.development? 
      session[:user_id] = 1
    end
    if session[:user_id]
      @current_user ||= User.find(session[:user_id])
    else
      nil
    end
  end

  def current_organization
    Organization.find(1)
  end

  def log_current_user
    if current_user
      logger.info "Current user: #{current_user.email}" 
    end
  end

  def user_manager?
    @user_manager ||= (current_user && current_user.is_manager?)
  end

  def user_manager!
    user_manager? or raise NotAllowed
  end

  def user_admin?
    @user_admin ||= (current_user && current_user.is_admin?)
  end

  def user_admin!
    user_admin? or raise NotAllowed
  end

  def modal_page?
    params[:modal] && params[:modal] == 'yyy'
  end

end
