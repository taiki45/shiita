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

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", items_path, "post" do
      assert_select "input#item_source[name=?]", "item[source]"
      assert_select "input#item_title[name=?]", "item[title]"
      assert_select "input#item_tags[name=?]", "item[tags]"
    end
  end
end
