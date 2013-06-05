require 'spec_helper'

describe ProfileController do
  describe "#show" do
    context "user not sign in" do
      it "should redirect to login page" do
        get :show

        response.status.should == 302
        response.should redirect_to new_user_session_path
      end
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

  describe "#update" do
    context "user not sign in" do
      it "should redirect to login page" do
        get :show

        response.status.should == 302
        response.should redirect_to new_user_session_path
      end
    end

    context "user sign in" do
      before do
        @user = create :user
        sign_in @user
      end

      context "update name" do
        it "should update success" do
          put :update, name: "xxx"

          @user.reload
          @user.name.should == "xxx"
        end
      end

      context "update address" do
        it "should update success" do
          put :update, address: "xxxx"

          @user.reload
          @user.address.should == "xxxx"
        end
      end

      context "update phone" do
        it "should update success" do
          put :update, phone: "135"

          @user.reload
          @user.phone.should == "135"
        end
      end
    end
  end
end
