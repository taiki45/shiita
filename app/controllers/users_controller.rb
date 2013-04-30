class UsersController < ApplicationController
  before_filter :require_login, only: :follow

  def show
    @user = User.find_by_part_of(params[:email])
  end

  def follow
    @obj = User.find_by_part_of(params[:email])
    current_user.follow(@obj)
    if current_user.save && @obj.save
      render "share/follow"
    else
      render "share/follow_error"
    end
  end

  def index
    @users = User.all.to_a
  end
end
