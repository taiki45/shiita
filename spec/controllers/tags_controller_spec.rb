require 'spec_helper'

describe TagsController do

  let(:tag) do
    Tag.create(
      name: "test"
    )
  end

  let(:item) do
    Item.create(
      title: "title",
      source: "source",
      tags: [tag]
    )
  end

  let(:user) do
    User.create!(
      uid: 1,
      name: "tester test",
      email: "test@example.com"
    )
  end

  let(:valid_session) { {id: 1} }

  before do
    controller.stub(:current_user) { user }
    Mecab::Ext::Parser.stub_chain("parse.surfaces.map.to_a").and_return(["MyString"])
    tag.items = [item]
    tag.users = [user]
    tag.save
  end

  describe "GET index" do
    it "assigns all value" do
      get :index
      assigns(:tags).should eq Tag.by_name.limit(25).skip(0)
    end
  end

  describe "GET show" do
    it "assigns requested tag items" do
      get :show, {name: tag.to_param}, valid_session
      assigns(:items).should eq tag.items
    end
  end

  describe "GET followers" do
    it "assigns requested tag" do
      get :followers, {name: tag.to_param}, valid_session
      assigns(:tag).should eq tag
    end
  end

  describe "PUT follow" do
    before { tag.users = [] }

    it "adds the tag to current_user.tag" do
      put :follow, {name: tag.to_param}, valid_session
      controller.__send__(:current_user).tags.should be_include tag
    end

    it "assigns requested tag name" do
      put :follow, {name: tag.to_param}, valid_session
      assigns(:target).should eq tag.name
    end
  end

  describe "DELETE follow" do
    it "adds the tag to current_user.tag" do
      delete :unfollow, {name: tag.to_param}, valid_session
      controller.__send__(:current_user).tags.should_not be_include tag
    end

    it "assigns requested tag name" do
      delete :unfollow, {name: tag.to_param}, valid_session
      assigns(:target).should eq tag.name
    end
  end

end
