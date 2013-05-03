require 'spec_helper'

describe Comment do

  it { should have_field(:content).of_type(String) }
  it { should have_field(:user_id).of_type(String) }
  it { should be_timestamped_document }

  it { should be_embedded_in(:item).of_type(Item) }

  it { should validate_presence_of(:content) }
  it { should validate_presence_of(:user_id) }

  describe "#user" do
    let(:user) { create :user }
    let(:valid_attrs) { {content: "test"} }

    subject { described_class.new(valid_attrs).tap {|o| o.user_id = user.id }.user }
    it { should eq user }
  end

  describe "#user=" do
    let(:user) { create :user }
    let(:valid_attrs) { {content: "test"} }

    subject { described_class.new(valid_attrs).tap {|o| o.user = user } }
    its(:user) { should eq user }
    its(:user_id) { should eq user.id.to_s }
  end

end
