class UsersController < ApplicationController

  before_filter :require_login, except: [:index, :show, :stocks, :followers, :followings]
  before_filter :set_user, except: :index

  def index
    @users = User.order_by(email: 1).page(params[:page]).per(USER_PAGING)
  end

  def show
  end

  def stocks
    @stocks = Kaminari.paginate_array(@user.stocks).page(params[:page])
  end

  def followers
  end

  def followings
  end

  def follow
    current_user.follow(@user)
    @target = @user.email

    respond_to do |format|
      if current_user.save
        format.js { render "share/action" }
      else
        format.js { render "share/action_error" }
      end
    end
  end

  def unfollow
    current_user.unfollow(@user)
    @target = @user.email

    respond_to do |format|
      if current_user.save
        format.js { render "share/action" }
      else
        format.js { render "share/action_error" }
      end
    end
  end

  private

  def set_user
    @user = User.find_by_part_of(params[:email])
  end

end
