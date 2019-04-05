class ApplicationController < ActionController::Base
  include Pundit

  I18n.locale = :it

  def pundit_user
    User.find(1)
  end

  def current_user
    User.find(1)
  end
end
