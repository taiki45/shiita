require 'spec_helper'

describe ItemsHelper do
  subject { helper }

  describe "generating paths" do
    it { should respond_to(:item_stock_path) }
    it { should respond_to(:comment_post_path) }
  end

end
