class TagsController < ApplicationController
  before_filter :require_login, only: :follow

  def show
    @tag = Tag.find_by(name: params[:name])
  end

  def follow
    @tag = Tag.find_by(name: params[:name])
    current_user.tags.push(@tag)
    flash[:notice] = "success to follow #{params[:name]}."
    render :show
  end
end
