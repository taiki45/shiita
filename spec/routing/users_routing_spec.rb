require "spec_helper"

describe UsersController do
  describe "routing" do

    it "routes to #show" do
      get("/users/test-t").should route_to("users#show", email: "test-t")
    end

  end
end
