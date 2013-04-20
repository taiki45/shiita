require 'spec_helper'

describe ApplicationController do
  describe "#current_user" do
    subject { controller.__send__ :current_user }

    let(:user) { create :user }

    context "with no user id in session" do
      it { should be_nil }
    end

    context "with correct user uid in session" do
      before { session[:uid] = user.uid }
      it { should eq user }
    end

    context "with wrong user uid in session" do
      before { session[:uid] = -1 }
      it { should be_nil }
    end
  end
end
