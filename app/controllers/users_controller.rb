class UsersController < ApplicationController
  def show
    @user = User.find_by_part_of(params[:email])
  end

  def follow
    @user = User.find_by_part_of(params[:email])
    current_user.follow(@user)
    flash[:notice] = "Success to follow #{@user.name}" if current_user.save && @user.save
    render :show
  end
end
