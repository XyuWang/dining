require 'spec_helper'

describe Storer::StorerController do
  describe "#show" do
    let!(:user) {create :user}

    context "user not sign in" do
      it "should redirect to login page" do
        get :show

        response.status.should == 302
        response.should redirect_to new_user_session_path
      end
    end

    context 'user sign in' do
      before do
        sign_in user
      end

      context "not is storer" do
        it "should redirect_to back" do
          get :show

          response.status.should == 302
        end
      end

      context "is storer" do
        before do
          user.roles << :storer
          user.save
        end

        it "should response successful" do
          get :show

          response.status.should == 200
        end
      end
    end
  end

  describe "#update" do
    let!(:user) {create :user}

    before do
      user.roles << :storer
      user.save

      sign_in user
    end

    it "should update attrbutes" do
      put :update, store: {name: "1", description: "2", free_deliver_price: 10}

      user.store.name.should == "1"
      user.store.description.should == "2"
      user.store.free_deliver_price.should == 10
    end
  end
end
