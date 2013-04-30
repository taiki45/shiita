class HomeController < ApplicationController

  def index
    @no_sidebar = true
    render :index and return unless login?

    @no_sidebar = false
    @items = current_user.following_items(20)
    @items = Item.order_by(updated_at: -1).limit(10).all if @items.empty?
    render :home
  end

  def help
    @no_sidebar = true
  end

end
