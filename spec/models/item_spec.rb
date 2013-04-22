require 'spec_helper'

describe Item do

  it { should have_field(:title).of_type(String) }
  it { should have_field(:source).of_type(String) }
  it { should be_timestamped_document }
  it { should belong_to(:user).of_type(User) }
  it { should have_and_belong_to_many(:tags).of_type(Tag) }

  describe "#user" do
    subject { create :item }

    its(:user) { should_not be_nil }
    its("user.uid") { should eq 1 }
  end

  describe "#tag_names" do
    subject { create(:item).tap {|e| e.tags = [create(:tag)] } }
    its(:tag_names) { should eq subject.tags.map {|e| e.name } }
  end

end
