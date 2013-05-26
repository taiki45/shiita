require 'spec_helper'

describe HomeController do

  before do
    @item = build(:item)
    @item.tags = [create(:tag)]
    @item.save
    @user = @item.user
  end

  describe "GET 'index'" do
    context "with no login" do
      it "returns http success" do
        get :index
        response.should be_success
      end

      it "assigns true to @no_sidebar" do
        get :index
        assigns(:no_sidebar).should be_true
      end
    end

    context "with login" do
      let(:user) { create :user }
      before do
        @user.tags = @item.tags
        @user.save
        session[:id] = @user.id
        controller.stub(:current_user) { @user }
      end

      it "assigns flase to no_sidebar" do
        get :index
        assigns(:no_sidebar).should be_false
      end

      it "assigns all following items with paging" do
        get :index
        assigns(:items).should eq @user.following_items.page(nil)
      end
    end
  end

end
