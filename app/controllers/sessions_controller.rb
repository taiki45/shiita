class SessionsController < ApplicationController
  def callback
    unless User.validate_domain(request.env['omniauth.auth'])
      flash[:error] = %(Use "#{Settings.email_domain}" email address to login.)
      redirect_to(root_path) && return
    end
    user = User.find_or_create_from_auth(request.env['omniauth.auth'])
    session[:id] = user.id
    flash[:notice] = "Success to login as #{user.name}."
    redirect_to root_path
  end

  def destroy
    reset_session
    flash[:notice] = "Success to logout."
    redirect_to root_path
  end
end
