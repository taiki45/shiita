require 'spec_helper'

describe Item do

  it { should have_field(:title).of_type(String) }
  it { should have_field(:source).of_type(String) }
  it { should have_field(:tags).of_type(Array) }
  it { should be_timestamped_document }
  it { should belong_to(:user) }

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
