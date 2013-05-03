require 'spec_helper'

describe Comment do

  it { should have_field(:content).of_type(String) }
  it { should have_field(:user_id).of_type(String) }
  it { should be_timestamped_document }

  it { should be_embedded_in(:item).of_type(Item) }

  it { should validate_presence_of(:content) }
  it { should validate_presence_of(:user_id) }

  describe ".new_with_user" do
    let(:user) { create :user }
    let(:valid_attrs) { {content: "test", user: user} }

    subject { described_class.new_with_user(valid_attrs) }
    it { should be_valid }
    its(:user_id) { should eq user.id.to_s }
  end

  describe "#user" do
    let(:user) { create :user }
    let(:valid_attrs) { {content: "test", user: user} }

    subject { described_class.new_with_user(valid_attrs).user }
    it { should eq user }
  end

end
