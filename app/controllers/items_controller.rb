class ItemsController < ApplicationController

  before_filter :require_login, except: [:index, :show]
  before_filter :set_item, except: [:index, :new, :create]

  def index
    @items = Item.recent.page(params[:page])

    respond_to do |format|
      format.html
      format.json { render json: @items }
    end
  end

  def show
    respond_to do |format|
      format.html
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
  end

  def create
    @item = Item.new(params[:item].merge({user: current_user}))

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
    respond_to do |format|
      if @item.update_attributes(params[:item])
        format.html { redirect_to @item, notice: 'Item was successfully updated.' }
        format.json { render json: @item, status: :updated, location: @item }
      else
        format.html { render action: "edit" }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @item.destroy

    respond_to do |format|
      format.html { redirect_to user_url(@item.user), notice: %(Success to delete "#{@item.title}".) }
      format.json { head :no_content }
    end
  end

  def stock
    current_user.stock(@item)
    @target = @item.title

    respond_to do |format|
      render_js(format, current_user)
    end
  end

  def unstock
    current_user.unstock(@item)
    @target = @item.title

    respond_to do |format|
      render_js(format, current_user)
    end
  end

  def comment
    comment = Comment.new_with_user(params[:comment].merge(user: current_user))
    @item.comments.push comment

    respond_to do |format|
      if comment.save
        format.html { render partial: "share/comment", object: comment }
      else
        format.html { render nothing: true, status: 400 }
      end
    end
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end

end
