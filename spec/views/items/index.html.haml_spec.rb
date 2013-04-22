require 'spec_helper'

describe "items/index" do
  before(:each) do
    assign(:items, [
      stub_model(Item,
        :source => "Source",
        :title => "Title",
        :tags => [
          stub_model(Tag, name: "Test"),
          stub_model(Tag, name: "Ruby")
        ]
      ),
      stub_model(Item,
        :source => "Source",
        :title => "Title",
        :tags => [stub_model(Tag, name: "Ruby")]
      )
    ])
  end

  it "renders a list of items" do
    render
  end
end
