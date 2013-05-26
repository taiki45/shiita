require 'spec_helper'

describe SessionsController do

  describe "#callback" do
    context "with invalid damain mail address" do
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
  end

end
