class TagsController < ApplicationController

  before_filter :require_login, except: [:show, :index, :followers]
  before_filter :set_tag, except: :index

  def show
    @items = Kaminari.paginate_array(@tag.items).page(params[:page])
  end

  def index
    @tags = Tag.by_name.page(params[:page])
  end

  def followers
  end

  def follow
    current_user.follow(@tag)
    @target = @tag.name

    respond_to do |format|
      if current_user.save
        format.js { render "share/action" }
      else
        format.js { render "share/action_error" }
      end
    end
  end

  def unfollow
    current_user.unfollow(@tag)
    @target = @tag.name

    respond_to do |format|
      if current_user.save
        format.js { render "share/action" }
      else
        format.js { render "share/action_error" }
      end
    end
  end

  private

  def set_tag
    @tag = Tag.find_by(name: params[:name])
  end

end
