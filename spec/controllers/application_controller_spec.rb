require 'spec_helper'

describe ApplicationController do

  let(:user) { create :user }

  describe "#current_user" do
    subject { controller.__send__ :current_user }

    context "with no user id in session" do
      it { should be_nil }
    end

    context "with correct user uid in session" do
      before { session[:id] = user.id }
      it { should eq user }
    end

    context "with wrong user uid in session" do
      before { session[:id], session[:should_reset] = -1, "has_value" }

      it "should reset session with wrong user" do
        expect(subject).to be_nil
        expect(session[:should_reset]).to be_nil
      end
    end
  end

  describe "#login?" do
    subject { controller.__send__ :login? }

    context "when user has logined" do
      before { session[:id] = user.id }
      it { should be_true }
    end

    context "when user has logouted" do
      before { session[:id] = nil }
      it { should be_false }
    end
  end

  describe "rescue_from" do
    controller do
      def test
        raise Mongoid::Errors::DocumentNotFound.new(User, {id: :dummy})
      end
    end

    context "with DocumentNotFound" do
      it "renders error page" do
        routes.draw { get "test" => "anonymous#test" }

        get :test
        response.code.should eq "404"
      end
    end
  end

end
