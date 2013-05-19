require 'spec_helper'

describe UsersHelper do
  subject { helper }

  describe "generating paths" do
    it { should respond_to(:users_path) }
    it { should respond_to(:user_path) }
    it { should respond_to(:user_follow_path) }
    it { should respond_to(:user_stocks_path) }
    it { should respond_to(:user_followings_path) }
    it { should respond_to(:user_followers_path) }
  end

end
