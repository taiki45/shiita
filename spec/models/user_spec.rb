require 'spec_helper'

describe User do

  describe "validations" do
    context "when it has unvalid data" do
      its(:valid?) { should be false }
    end

    context "when it has valid data" do
      subject do
        User.new(
          name: 'name',
          email: 'mail@gamil.com',
          uid: '1'
        )
      end

      its(:valid?) { should be true }
    end
  end

end
