require 'spec_helper'

describe UsersHelper do
  subject { helper }

  describe "generating paths" do
    it { should respond_to(:users_path) }
    it { should respond_to(:user_path) }
    it { should respond_to(:follow_user_path) }
    it { should respond_to(:stocks_user_path) }
    it { should respond_to(:followings_user_path) }
    it { should respond_to(:followers_user_path) }
  end

end
