require 'spec_helper'

describe CartController do
  describe "#show" do
    context "user not sign in" do
      it "should redirect_to login page" do
        get :show

        response.should redirect_to new_user_session_path
      end
    end

    context "user sign in" do
      before do
        @user = create :user
        sign_in @user
      end

      it "should response success" do
        get :show

        response.status.should == 200
      end
    end
  end

  describe "#add product" do
    context "user not sign in" do
      it "should redirect_to login page" do
        post :add_product, product_id: 1

        response.should redirect_to new_user_session_path
      end
    end

    context "user sign in" do
      before do
        @user = create :user
        sign_in @user
      end

      context "product not exist" do
        it "should response 404" do
          lambda do
            post :add_product, product_id: 1
          end.should change(@user.cart.line_items, :count).by 0

          response.status.should == 404
        end
      end


      context "product exist" do
        let!(:product) {create :product}

        it "should add product" do
          lambda do
            post :add_product, product_id: product.id
          end.should change{ @user.reload; @user.cart.line_items.count }.by 1

        end
      end
    end
  end


  describe "#remove product" do
    context "user not sign in" do
      it "should redirect_to login page" do
        delete :remove_product, product_id: 1

        response.should redirect_to new_user_session_path
      end
    end

    context "user sign in" do
      before do
        @user = create :user
        sign_in @user
      end

      context "line_item not exist" do
        it "should response 404" do
          lambda do
            delete :remove_product, line_item_id: 1
          end.should change(@user.cart.line_items, :count).by 0

          response.status.should == 404
        end
      end


      context "line_item exist" do
        let!(:line_item){create :line_item, cart_id: @user.cart.id}
        it "should remove line_item" do
          lambda do
            delete :remove_product, line_item_id: line_item.id
          end.should change{ @user.reload; @user.cart.line_items.count }.by -1
        end
      end
    end
  end

  describe "#total price" do
    context "user not sign in" do
      it "should redirect_to login page" do
        delete :remove_product, product_id: 1

        response.should redirect_to new_user_session_path
      end
    end

    context "user sign in" do
      before do
        @user = create :user
        sign_in @user
      end

      it "should got the total_price" do
        CartDomain.stub(:get_total_price){100}

        get :total_price

        res = JSON.parse(response.body)
        res["total_price"].should == 100
      end

      it "should got the free_deliver_price" do
        store = create :store, free_deliver_price: 20
        @user.cart.store_id = store.id
        @user.cart.save

        get :total_price

        res = JSON.parse(response.body)
        res["free_deliver_price"].should == "20.0"
      end
    end
  end

  describe "#update" do
    context "user not sign in" do
      it "should redirect_to login page" do
        delete :remove_product, product_id: 1

        response.should redirect_to new_user_session_path
      end
    end

    context "user sign in" do
      before do
        @user = create :user
        sign_in @user
      end

      it "should change the line_item quantity" do

        line_item = create :line_item, cart_id: @user.cart.id, quantity: 1
        lambda do
        put :update, line_item_id: line_item.id, quantity: 2
        end.should change{line_item.reload; line_item.quantity}.by 1
      end
    end
  end
end
