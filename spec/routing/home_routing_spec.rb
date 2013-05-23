require 'spec_helper'

describe HomeController do
  describe "routing" do

    it "routes to #index" do
      get("/").should route_to("home#index")
    end

    it "routes to #help" do
      get("/help").should route_to("home#help")
    end

    it "routes to #search" do
      get("/search").should route_to("home#search")
    end

  end
end
