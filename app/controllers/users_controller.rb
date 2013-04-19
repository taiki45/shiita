class UsersController < ApplicationController
  def show
    @user = User.find_by_part_of(params[:email])
  end
end
