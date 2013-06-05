require 'spec_helper'

describe ProductsController do
  describe "#show" do
    context "user not sign in" do
      get :show

      response.status.should == 301
      response.should redirect_to new_user_session_path
    end

    context "user sign in" do
      before do
        user = create :user
        sign_in user
      end

      it "should response success" do
        get :show
        response.status.should == 200
      end
    end
  end
end
