require 'spec_helper'

describe ItemsController do

  before do
    user = User.create!(
      uid: 1,
      name: "tester test",
      email: "test@example.com"
    )
    controller.stub(:current_user) { user }
  end

  let(:item) { Item.create! valid_attributes }
  let(:redirect_path) { "home#index" }
  let(:valid_session) { {id: 1} }
  let(:valid_attributes) do
    {
      "source" => "MyString",
      "title" => "MyTitle",
      "tag_names" => "Ruby Test",
    }
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

pending do

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Item" do
        expect {
          post :create, {item: valid_attributes}, valid_session
        }.to change(Item, :count).by(1)
      end

      it "assigns a newly created item as @item" do
        post :create, {item: valid_attributes}, valid_session
        assigns(:item).should be_a(Item)
        assigns(:item).should be_persisted
      end

      it "redirects to the created item" do
        post :create, {item: valid_attributes}, valid_session
        response.should redirect_to(Item.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved item as @item" do
        # Trigger the behavior that occurs when invalid params are submitted
        Item.any_instance.stub(:save).and_return(false)
        post :create, {item: { "source" => "invalid value" }}, valid_session
        assigns(:item).should be_a_new(Item)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Item.any_instance.stub(:save).and_return(false)
        post :create, {item: { "source" => "invalid value" }}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested item" do
        item = Item.create! valid_attributes
        # Assuming there are no other items in the database, this
        # specifies that the Item created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Item.any_instance.should_receive(:update_attributes).with({ "source" => "MyString" })
        put :update, {id: item.to_param, item: {source: "MyString"}}, valid_session
      end

      it "assigns the requested item as @item" do
        item = Item.create! valid_attributes
        put :update, {id: item.to_param, item: valid_attributes, }, valid_session
        assigns(:item).should eq(item)
      end

      it "redirects to the item" do
        item = Item.create! valid_attributes
        put :update, {id: item.to_param, item: valid_attributes}, valid_session
        response.should redirect_to(item)
      end
    end

    describe "with invalid params" do
      it "assigns the item as @item" do
        item = Item.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Item.any_instance.stub(:save).and_return(false)
        put :update, {:id => item.to_param, :item => { "source" => "invalid value" }}, valid_session
        assigns(:item).should eq(item)
      end

      it "re-renders the 'edit' template" do
        item = Item.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Item.any_instance.stub(:save).and_return(false)
        put :update, {:id => item.to_param, :item => { "source" => "invalid value" }}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested item" do
      item = Item.create! valid_attributes
      expect {
        delete :destroy, {:id => item.to_param}, valid_session
      }.to change(Item, :count).by(-1)
    end

    it "redirects to the items list" do
      item = Item.create! valid_attributes
      delete :destroy, {:id => item.to_param}, valid_session
      response.should redirect_to(items_url)
    end
  end

end

end
