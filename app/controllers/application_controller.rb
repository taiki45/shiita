class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :login?, :current_user

  private

  def login?
    session[:id] && current_user
  end

  def current_user
    @current_user ||= User.find(session[:id]) if session[:id]
  rescue Mongoid::Errors::DocumentNotFound
    reset_session
  end
end
