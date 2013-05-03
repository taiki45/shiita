require 'spec_helper'

describe Comment do

  it { should have_field(:content).of_type(String) }
  it { should have_field(:user_id).of_type(String) }
  it { should be_timestamped_document }

  it { should be_embedded_in(:item).of_type(Item) }

  it { should validate_presence_of(:content) }
  it { should validate_presence_of(:user_id) }

end
