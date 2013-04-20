class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :login?, :current_user

  private

  def login?
    session[:uid] && current_user
  end

  def current_user
    User.where(uid: session[:uid]).first
  end
end
