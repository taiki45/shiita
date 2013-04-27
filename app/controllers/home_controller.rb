class HomeController < ApplicationController
  def index
    @no_sidebar = true
    render :index and return unless login?

    @no_sidebar = false
    @following_tags = current_user.tags
    @items = current_user.following_items
    render :home
  end
end
