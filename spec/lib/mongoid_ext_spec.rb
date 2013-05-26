require 'spec_helper'

describe Bignum do

  describe "#mongoize" do
    subject { 10000000000000000000.mongoize }
    it { should eq "10000000000000000000" }
  end

end
