require 'spec_helper'

describe ItemsController do

  before do
    controller.stub(:current_user) { user }
    Mecab::Ext::Parser.stub_chain("parse.surfaces.map.to_a").and_return(["MyString"])
  end

  let(:user) do
    User.create!(
      uid: 1,
      name: "tester test",
      email: "test@example.com"
    )
  end
  let(:current_user) { controller.__send__(:current_user) }
  let(:item) { Item.create! valid_attributes }
  let(:redirect_path) { "home#index" }
  let(:valid_session) { {id: 1} }
  let(:valid_attributes) do
    {
      "source" => "MyString",
      "title" => "MyTitle",
      "tag_names" => %w(Ruby Test),
    }
  end

  describe "GET index" do
    it "assigns all items" do
      get :index
      assigns(:items).should eq Item.recent.limit(25).skip(0)
    end
  end

  describe "GET show" do
    it "assigns the requested item as @item" do
      get :show, {:id => item.to_param}, valid_session
      assigns(:item).should eq item
    end

    it "assigns the requested item as @item even if not logged in" do
      get :show, {id: item.to_param}, {}
      assigns(:item).should eq item
    end
  end

  describe "GET new" do
    it "assigns a new item as @item" do
      get :new, {}, valid_session
      assigns(:item).should be_a_new Item
    end

    it "redirects home#index unless logged in" do
      subject = get :new, {}, {}
      should redirect_to redirect_path
    end
  end

  describe "GET edit" do
    it "assigns the requested item as @item" do
      get :edit, {:id => item.to_param}, valid_session
      assigns(:item).should eq item
    end

    it "redirects home#index unless logged in" do
      subject = get :edit, {}, {}
      should redirect_to redirect_path
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Item" do
        expect {
          post :create, {item: valid_attributes}, valid_session
        }.to change(Item, :count).by(1)
      end

      it "assigns a newly created item as @item" do
        post :create, {item: valid_attributes}, valid_session
        assigns(:item).should be_a Item
        assigns(:item).should be_persisted
      end

      it "redirects to the created item" do
        post :create, {item: valid_attributes}, valid_session
        response.should redirect_to Item.last
      end
    end

    describe "with invalid params" do
      before { Item.any_instance.stub(:save).and_return(false) }

      it "assigns a newly created but unsaved item as @item" do
        # Trigger the behavior that occurs when invalid params are submitted
        post :create, {item: { "source" => "invalid value" }}, valid_session
        assigns(:item).should be_a_new Item
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        post :create, {item: { "source" => "invalid value" }}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested item" do
        # Assuming there are no other items in the database, this
        # specifies that the Item created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Item.any_instance.should_receive(:update_attributes).with({ "source" => "MyString" })
        put :update, {id: item.to_param, item: {source: "MyString"}}, valid_session
      end

      it "assigns the requested item as @item" do
        put :update, {id: item.to_param, item: valid_attributes, }, valid_session
        assigns(:item).should eq(item)
      end

      it "redirects to the item" do
        put :update, {id: item.to_param, item: valid_attributes}, valid_session
        response.should redirect_to(item)
      end
    end

    describe "with invalid params" do
      before { Item.any_instance.stub(:save).and_return(false) }

      it "assigns the item as @item" do
        # Trigger the behavior that occurs when invalid params are submitted
        put :update, {:id => item.to_param, :item => { "source" => "invalid value" }}, valid_session
        assigns(:item).should eq(item)
      end

      it "re-renders the 'edit' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        put :update, {:id => item.to_param, :item => { "source" => "invalid value" }}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    before do
      Item.any_instance.stub(:user) { user }
      item
    end

    it "destroys the requested item" do
      expect {
        delete :destroy, {:id => item.to_param}, valid_session
      }.to change(Item, :count).by(-1)
    end

    it "redirects to the items list" do
      delete :destroy, {:id => item.to_param}, valid_session
      response.should redirect_to(user_url(user))
    end

    it "has success message in flash" do
      delete :destroy, {:id => item.to_param}, valid_session
      flash[:notice].should match /delete/
      flash[:notice].should match /#{item.title}/
    end
  end

  describe "PUT stock" do
    before { current_user.tap {|o| o.stocks = [] }.save }

    it "lets current user stock the item" do
      expect(current_user.stocks).to have(:no).item
      put :stock, {id: item.to_param}, valid_session
      expect(current_user.stocks).to have(1).item
    end
  end

  describe "DELETE stock" do
    before { current_user.tap {|o| o.stocks.push item }.save }

    it "lets current user unstock the item" do
      expect(current_user.stocks).to have(1).item
      delete :unstock, {id: item.to_param}, valid_session
      expect(current_user.stocks).to have(:no).item
    end
  end

  describe "PUT comment" do
    it "assigns requested item" do
      put :comment, {id: item.to_param, comment: {content: "test"}}, valid_session
      assigns(:item).should eq item
    end

    it "comments the item" do
      expect(Item.find(item.id).comments).to have(:no).comments
      put :comment, {id: item.to_param, comment: {content: "test"}}, valid_session
      expect(Item.find(item.id).comments).to have(1).comment
    end

    context "with failure" do
      before { Comment.any_instance.should_receive(:save).twice.and_return(false) }

      it "" do
        expect(Item.find(item.id).comments).to have(:no).comments
        put :comment, {id: item.to_param, comment: {content: "test"}}, valid_session
        expect(Item.find(item.id).comments).to have(:no).comment
      end
    end
  end

end
