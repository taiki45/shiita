require 'spec_helper'

describe Tag do

  it { should have_field(:name).of_type(String) }
  it { should_not be_timestamped_document }
  it { should have_and_belong_to_many(:items).of_type(Item) }

  it { should have_index_for(name: 1) }
  it { should have_index_for(item_ids: 1).with_options(background: true) }

  describe "#to_param" do
    subject { create :tag }
    its(:to_param) { should eq subject.name }
  end

end
