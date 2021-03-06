class HomeController < ApplicationController
  def index
    @no_sidebar = true
    render :index and return unless login?

    @no_sidebar = false
    @items = current_user.following_items.page(params[:page])
    @items = Item.order_by(updated_at: -1).page(params[:page]) if @items.count < 1
    render :home
  end

  def help
    @no_sidebar = true
  end

  def search
    @items = Item.search(params[:query]).to_a
  end
end
