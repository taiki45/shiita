require 'spec_helper'

describe "items/show" do
  before(:each) do
    @item = assign(:item, stub_model(Item,
      :source => "Source",
      :title => "Title",
      :tags => [],
      :user => stub_model(User, name: "Username")
    ))
  end

  it "renders attributes in <p>" do
    pending "learn view test"
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Source/)
    rendered.should match(/Title/)
    rendered.should match(//)
  end
end
