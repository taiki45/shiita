class UsersController < ApplicationController

  before_filter :require_login, only: :follow

  def show
    @user = User.find_by_part_of(params[:email])
  end

  def follow
    user = User.find_by_part_of(params[:email])
    current_user.follow(user)

    @target = user.email
    if current_user.save && user.save
      render "share/action"
    else
      render "share/action_error"
    end
  end

  def index
    @users = User.all.to_a
  end
end
