require 'spec_helper'

describe TagsHelper do
  subject { helper }

  describe "generating paths" do
    it { should respond_to :tags_path }
    it { should respond_to :tag_path }
    it { should respond_to :followers_tag_path }
    it { should respond_to :follow_tag_path }
  end

end
