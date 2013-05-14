class ItemsController < ApplicationController

  before_filter :require_login, except: [:index, :show]

  def index
    @items = Item.recent.to_a

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @items }
    end
  end

  def show
    @item = Item.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @item }
    end
  end

  def new
    @item = Item.new

    respond_to do |format|
      format.html
      format.json { render json: @item }
    end
  end

  def edit
    @item = Item.find(params[:id])
  end

  def create
    @item = Item.new(params[:item])
    @item.user = current_user

    respond_to do |format|
      if @item.save
        format.html { redirect_to @item, notice: 'Item was successfully created.' }
        format.json { render json: @item, status: :created, location: @item }
      else
        format.html { render action: "new" }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @item = Item.find(params[:id])

    respond_to do |format|
      if @item.update_attributes(params[:item])
        format.html { redirect_to @item, notice: 'Item was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy

    respond_to do |format|
      format.html { redirect_to user_url(@item.user), notice: %(Success to delete "#{@item.title}".) }
      format.json { head :no_content }
    end
  end

  def stock
    item = Item.find(params[:id])
    current_user.stock(item)

    @target = item.title
    if current_user.save
      render "share/action"
    else
      render "share/action_error"
    end
  end

  def comment
    comment = Comment.new_with_user(params[:comment].merge(user: current_user))
    Item.find(params[:id]).comments.push comment

    if comment.save
      render partial: "share/comment", object: comment
    else
      render :nothing
    end
  end

end
