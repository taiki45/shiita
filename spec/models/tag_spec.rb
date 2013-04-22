require 'spec_helper'

describe Tag do

  it { should have_field(:name).of_type(String) }
  it { should_not be_timestamped_document }
  it { should have_and_belong_to_many(:items).of_type(Item) }

  describe "#to_param" do
    subject { create :tag }
    its(:to_param) { should eq subject.name }
  end

end
