class TagsController < ApplicationController
  before_filter :require_login, only: :follow

  def show
    @tag = Tag.find_by(name: params[:name])
  end

  def follow
    @obj = Tag.find_by(name: params[:name])
    current_user.tags.push(@obj)
    if current_user.save
      render "share/follow"
    else
      render "share/follow_error"
    end
  end

  def index
    @tags = Tag.all.to_a
  end
end
