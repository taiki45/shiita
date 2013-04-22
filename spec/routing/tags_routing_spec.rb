require "spec_helper"

describe TagsController do
  describe "routing" do

    it "routes to #show" do
      get("/tags/test").should route_to("tags#show", name: "test")
    end

  end
end
