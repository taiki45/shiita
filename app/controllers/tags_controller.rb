class TagsController < ApplicationController

  before_filter :require_login, only: :follow

  def show
    @tag = Tag.find_by(name: params[:name])
  end

  def follow
    tag = Tag.find_by(name: params[:name])
    current_user.tags.push(tag)

    @target = tag.name
    if current_user.save
      render "share/action"
    else
      render "share/action_error"
    end
  end

  def index
    @tags = Tag.all.to_a
  end
end
