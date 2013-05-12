class TagsController < ApplicationController

  before_filter :require_login, only: :follow
  before_filter :set_tag, only: [:show, :followers]

  def show
  end

  def follow
    tag = Tag.find_by(name: params[:name])
    current_user.follow_tag(tag)

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

  def followers
  end

  private

  def set_tag
    @tag = Tag.find_by(name: params[:name])
  end
end
