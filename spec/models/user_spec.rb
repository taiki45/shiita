require 'spec_helper'

describe User do

  describe "validations" do
    context "when it has unvalid data" do
      its(:valid?) { should be false }
    end

    context "when it has valid data" do
      subject { build :user }
      its(:valid?) { should be true }
    end
  end

  describe "#create" do
    before { create :user }
    subject { User.first }

    its(:uid) { should eq 1 }
    its(:name) { should eq "taiki" }
    its(:email) { should eq "taiki@example.com" }
  end

end
