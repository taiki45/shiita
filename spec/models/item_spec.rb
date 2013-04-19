require 'spec_helper'

describe Item do

  describe "#created_at" do
    subject { create :item }
    its(:created_at) { should be_within(10.seconds).of(Time.now) }
  end

  describe "updated_at" do
    subject { create :item }
    its(:updated_at) { should be_within(10.seconds).of(Time.now) }

    it "should updated when updated its value" do
      before = subject.updated_at
      subject.tap {|item| item.title = "updated" }.save
      expect(subject.updated_at).not_to eq before
    end
  end

  describe "#user" do
    subject { create :item }

    its(:user) { should_not be_nil }
    its("user.uid") { should eq 1 }
  end

  describe "#tags" do
    subject { create :item }
    its(:tags) { should have(2).tags }
    its(:tags) { should be_include "Ruby" }
  end

end
