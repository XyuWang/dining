require 'spec_helper'

describe ProductsController do
  describe "#show" do
    let!(:product) {create :product}

    context "user not sign in" do
      it "should response success" do
        get :show, format: "html", id: product.id

        response.status.should == 200
      end
    end

    context "user sign in" do
      before do
        user = create :user
        sign_in user
      end

      it "should response success" do
        get :show, format: "html", id: product.id
        response.status.should == 200
      end
    end
  end
end
