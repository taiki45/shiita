require 'spec_helper'

describe SessionsController do

  describe "#callback" do
    context "with invalid domain mail address" do
      before { User.should_receive(:validate_domain).and_return(false) }

      it "set error message" do
        get :callback
        expect(flash[:error]).to match /example\.com/
      end

      it "redirects to root" do
        get :callback
        response.should redirect_to(controller: :home, action: :index)
      end
    end

    context "with valid email domain address" do
      before do
        User.should_receive(:validate_domain).and_return(true)
        User.should_receive(:find_or_create_from_auth).and_return(
          stub_model(User, id: 5, name: "test")
        )
      end

      it "sets user id to session[:id]" do
        get :callback
        expect(session[:id]).to eq 5
      end

      it "sets success message to flash" do
        get :callback
        expect(flash[:notice]).to match /Success/
      end

      it "sets user name with success message" do
        get :callback
        expect(flash[:notice]).to match /test/
      end

      it "redirects to root" do
        get :callback
        response.should redirect_to(controller: :home, action: :index)
      end
    end
  end

end
