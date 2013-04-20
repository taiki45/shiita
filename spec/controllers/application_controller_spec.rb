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
      before { session[:id] = -1 }
      it { should be_nil }
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

end
