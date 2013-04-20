class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :login?, :current_user

  private

  def login?
    session[:id] && current_user
  end

  def current_user
    User.where(id: session[:id]).first
  end
end
