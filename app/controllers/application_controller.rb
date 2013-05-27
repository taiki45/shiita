class ApplicationController < ActionController::Base

  protect_from_forgery
  helper_method :login?, :current_user

  rescue_from Mongoid::Errors::DocumentNotFound,
    with: ->{ render "public/404", layout: false, status: 404 }

  private

  USER_PAGING = 30

  def login?
    session[:id] && current_user
  end

  def current_user
    @current_user ||= User.find(session[:id]) if session[:id]
  rescue Mongoid::Errors::DocumentNotFound
    reset_session
  end

  def require_login
    redirect_to "home#index" unless login?
  end

  def render_js(format, source)
    if source.save
      format.js { render "share/action" }
    else
      format.js { render "share/action_error" }
    end
  end

end
