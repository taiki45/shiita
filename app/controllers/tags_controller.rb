class TagsController < ApplicationController

  before_filter :require_login, only: [:follow, :unfollow]
  before_filter :set_tag, except: :index

  def show
  end

  def follow
    current_user.follow(@tag)
    @target = @tag.name
    if current_user.save
      render "share/action"
    else
      render "share/action_error"
    end
  end

  def unfollow
    current_user.unfollow(@tag)
    @target = @tag.name
    if current_user.save
      render "share/action"
    else
      render "share/action_error"
    end
  end

  def index
    @tags = Tag.by_name.to_a
  end

  def followers
  end

  private

  def set_tag
    @tag = Tag.find_by(name: params[:name])
  end

end
