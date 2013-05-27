require 'spec_helper'

describe UsersController do

  let(:user) do
    User.create!(
      uid: 1,
      name: "tester test",
      email: "test@example.com"
    )
  end

  let(:other) do
    create :user, uid: 2, email: "test2@example.com"
  end

  let(:valid_session) { {id: 1} }

  before do
    controller.stub(:current_user) { user }
    Mecab::Ext::Parser.stub_chain("parse.surfaces.map.to_a").and_return(["MyString"])
    Settings.stub(:email_domain).and_return("example.com")
  end

  describe "GET index" do
    it "assigns all users" do
      get :index
      assigns(:users).should eq User.order_by(:email.asc).limit(30).skip(0)
    end
  end

  describe "GET show" do
    it "assigns requested user" do
      get :show, {email: user.to_param}, valid_session
      assigns(:user).should eq user
    end
  end

  describe "GET stocks" do
    it "assigns requested user" do
      get :stocks, {email: user.to_param}, valid_session
      assigns(:user).should eq user
    end
  end

  describe "GET followers" do
    it "assigns requested user's followers" do
      get :followers, {email: user.to_param}, valid_session
      assigns(:user).should eq user
    end
  end

  describe "GET followings" do
    it "assigns requested user's followings" do
      get :followers, {email: user.to_param}, valid_session
      assigns(:user).should eq user
    end
  end

  describe "PUT follow" do
    before { user.followings = [] }

    context "with success" do
      it "adds the user to current_user.user" do
        put :follow, {email: other.to_param}, valid_session
        controller.__send__(:current_user).followings.should be_include other
        flesh_other = User.find(other.id)
        flesh_other.followers.should be_include user
      end

      it "assigns requested user email" do
        put :follow, {email: other.to_param}, valid_session
        assigns(:target).should eq other.email
      end
    end

    context "with failed" do
      before { controller.__send__(:current_user).should_receive(:save).and_return(false) }

      it "response unprocessable_entity" do
        put :follow, {email: other.to_param}, valid_session
        response.code.should eq "406"
      end
    end
  end

  describe "DELETE follow" do
    before { controller.__send__(:current_user).follow(other) }

    context "with success" do
      it "drops the user to current_user.user" do
        expect {
          delete :unfollow, {email: other.to_param}, valid_session
        }.to change { User.find(controller.__send__(:current_user).id).followings.count }.by -1
      end

      it "drops the user from other's followers" do
        expect {
          delete :unfollow, {email: other.to_param}, valid_session
        }.to change { other.followers.count }.by -1
      end

      it "assigns requested user email" do
        delete :unfollow, {email: other.to_param}, valid_session
        assigns(:target).should eq other.email
      end
    end

    context "with failed" do
      before { controller.__send__(:current_user).should_receive(:save).and_return(false) }

      it "response unprocessable_entity" do
        delete :unfollow, {email: other.to_param}, valid_session
        response.code.should eq "406"
      end
    end
  end

end
