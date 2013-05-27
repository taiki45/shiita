require "spec_helper"

describe TagsController do
  describe "routing" do

    it "routes to #show" do
      get("/tags/test").should route_to("tags#show", name: "test")
    end

    it "routes to #show with pagination" do
      get("/tags/test/page/1").should route_to("tags#show", name: "test", page: "1")
    end

    it "routes to #index" do
      get("/tags").should route_to("tags#index")
    end

    it "routes to #follow" do
      post("/tags/test/follow").should route_to("tags#follow", name: "test")
    end

    it "routes to #unfollow" do
      delete("/tags/test/follow").should route_to("tags#unfollow", name: "test")
    end

    it "routes to #followers" do
      get("/tags/test/followers").should route_to("tags#followers", name: "test")
    end

  end
end
