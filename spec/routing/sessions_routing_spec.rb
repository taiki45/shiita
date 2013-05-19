require "spec_helper"

describe SessionsController do
  describe "routing" do

    it "routes to #callback" do
      get("/auth/test/callback").should route_to("sessions#callback", provider: "test")
    end

    it "routes to #destroy" do
      delete("/logout").should route_to("sessions#destroy")
    end

  end
end
