class UsersController < ApplicationController

  before_filter :require_login, only: :follow
  before_filter :set_user, except: :index

  def index
    @users = User.all.to_a
  end

  def show
  end

  def follow
    user = User.find_by_part_of(params[:email])
    current_user.follow_user(user)

    @target = user.email
    if current_user.save
      render "share/action"
    else
      render "share/action_error"
    end
  end

  def stocks
  end

  def followers
  end

  def followings
  end

  private

  def set_user
    @user = User.find_by_part_of(params[:email])
  end

end
