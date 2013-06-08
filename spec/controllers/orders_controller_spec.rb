require 'spec_helper'

describe OrdersController do
  describe "#index" do
    let!(:user) {create :user}

    context "user not sign in " do
      it "should redirect_to login page" do
        get :index

        response.status.should == 302
        response.should redirect_to new_user_session_path
      end
    end

    context "user sign in" do
      before do
        @order_1 = build :order, user: user
        @order_1.save(validate: false)
        @order_2 = build :order, user: user
        @order_2.save(validate: false)

        sign_in user
      end

      it "should response success" do
        get :index

        response.status.should == 200
      end

      it "should got the orders" do
        get :index

        assigns(:orders).should == [@order_2, @order_1]
      end
    end
  end

  describe "POST #create" do
    let!(:user) {create :user}

    context "user not sign in " do
      it "should redirect_to login page" do
        post :create

        response.status.should == 302
        response.should redirect_to new_user_session_path
      end
    end

    context "user sign in" do
      before do
        sign_in user
      end

      context "cart have items" do
        before do
          line_item = create :line_item, cart: user.cart
          create :line_item, cart: user.cart, price: 10000
          create :line_item, cart: user.cart

          cart = user.cart
          cart.store_id = line_item.product.store.id
          cart.save
        end

        it "should create the order" do
          lambda do
            post :create, message: "message", address: "address", phone: "12233", name: "name"
          end.should change(user.orders, :count).by 1
        end

        it "should destroy the cart line_items" do
          lambda do
            post :create, message: "message", address: "address", phone: "12233", name: "name"
          end.should change(user.cart.line_items, :count).by -3
        end
      end
    end
  end
end
