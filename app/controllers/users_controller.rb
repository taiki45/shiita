class UsersController < ApplicationController

  before_filter :require_login, except: [:index, :show, :stocks, :followers, :followings]
  before_filter :set_user, except: :index

  def index
    @users = User.order_by(email: 1).to_a
  end

  def show
  end

  def stocks
  end

  def followers
  end

  def followings
  end

  def follow
    current_user.follow(@user)
    @target = @user.email
    if current_user.save
      render "share/action"
    else
      render "share/action_error"
    end
  end

  def unfollow
    current_user.unfollow(@user)
    @target = @user.email
    if current_user.save
      render "share/action"
    else
      render "share/action_error"
    end
  end

  private

  def set_user
    @user = User.find_by_part_of(params[:email])
  end

end
