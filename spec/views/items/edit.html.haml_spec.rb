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

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", item_path(@item), "post" do
      assert_select "input#item_source[name=?]", "item[source]"
      assert_select "input#item_title[name=?]", "item[title]"
      assert_select "input#item_tags[name=?]", "item[tags]"
    end
  end
end
