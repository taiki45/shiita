require 'spec_helper'

describe Item do

  it { should have_field(:title).of_type(String) }
  it { should have_field(:source).of_type(String) }
  it { should be_timestamped_document }

  it { should belong_to(:user).with_foreign_key(:user_id).of_type(User) }
  it { should have_and_belong_to_many(:tags).with_foreign_key(:tag_ids).of_type(Tag) }
  it { should have_and_belong_to_many(:stocked_users).with_foreign_key(:stocked_user_ids).of_type(User) }

  it { should have_index_for(updated_at: -1) }
  it { should have_index_for(user_id: 1).with_options(background: true) }
  it { should have_index_for(tag_ids: 1).with_options(background: true) }

  it { should validate_presence_of(:source) }
  it { should validate_presence_of(:title) }
  it { should validate_associated(:tags) }


  describe "#user" do
    subject { create :item }

    its(:user) { should_not be_nil }
    its("user.uid") { should eq 1 }
  end

  describe "#tag_names" do
    subject { create(:item).tap {|e| e.tags = [create(:tag)] } }
    its(:tag_names) { should eq subject.tags.map {|e| e.name }.join(" ") }
  end

end
