require 'spec_helper'

describe "items/edit" do
  before(:each) do
    @item = assign(:item, stub_model(Item,
      :source => "MyString",
      :title => "MyString",
      :tags => ""
    ))
  end

  it "renders the edit item form" do
    render
  end
end
