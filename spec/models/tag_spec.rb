require 'spec_helper'

describe Tag do

  it { should have_field(:name).of_type(String) }
  it { should_not be_timestamped_document }
  it { should have_and_belong_to_many(:items).of_type(Item).with_foreign_key(:item_ids) }
  it { should have_and_belong_to_many(:users).of_type(User).with_foreign_key(:user_ids) }

  it { should have_index_for(name: 1) }
  it { should have_index_for(item_ids: 1).with_options(background: true) }
  it { should have_index_for(user_ids: 1).with_options(background: true) }

  it { should validate_presence_of :name }
  it { should validate_uniqueness_of :name }

  describe "#to_param" do
    subject { create :tag }
    its(:to_param) { should eq subject.name }
  end

  describe "items default order" do

    pending do
      let(:ordered_items) do
        one = create(:item, title: "1")
        two = create(:item, title: "2", user: one.user)
        three = create(:item, title: "3", user: one.user)
        two.tap {|o| o.updated_at = Time.zone.today - 1 }.save
        three.tap {|o| o.updated_at = Time.zone.today - 2 }.save
        [three, two, one]
      end
      let(:new_one) { create :tag }
      before { new_one.items.push(*ordered_items.shuffle) }

      subject { new_one.items }
      it "is ordered by its update_at" do
      end
    end

  end

end
