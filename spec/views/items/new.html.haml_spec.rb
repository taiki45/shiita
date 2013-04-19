require 'spec_helper'

describe "items/new" do
  before(:each) do
    assign(:item, stub_model(Item,
      :source => "MyString",
      :title => "MyString",
      :tags => ""
    ).as_new_record)
  end

  it "renders new item form" do
    render
  end
end
