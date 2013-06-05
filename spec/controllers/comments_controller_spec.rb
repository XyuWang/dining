require 'spec_helper'

describe CommentsController do
  let!(:product) {create :product}

  describe "#index" do
    it "should response success" do
      get :index, product_id: product.id, format: 'js'

      response.status.should == 200
    end
  end

  describe "#new" do
    context "user not sign in" do
      it "should redirect to login page" do
        get :new, order_id: 1

        response.status.should == 302
        response.should redirect_to new_user_session_path
      end
    end

    context "user sign in" do
      before do
        @user = create :user
        sign_in @user
      end

      let!(:order) {
        g = FactoryGirl.build(:order, user_id: @user.id)
        g.save(:validate => false)
        g
      }
      it "should response success" do
        get :new, order_id: order.id

        response.status.should == 200
      end
    end
  end

  describe "#destroy" do
    before do
      @user = create :user
      @comment = create :comment, user: @user
    end

    context "user not sign in" do
      it "should redirect to login page" do
        delete :destroy, id: @comment.id

        response.status.should == 302
        response.should redirect_to new_user_session_path
      end
    end

    context "user sign in" do
      before do
        sign_in @user
      end

      it "should destroy the comment" do
        lambda do
          delete :destroy, id: @comment.id
        end.should change(@user.comments, :count).by -1
      end
    end
  end

  describe "#create" do
    context "user not sign in" do
      it "should redirect to login page" do
        post :create, id: 1

        response.status.should == 302
        response.should redirect_to new_user_session_path
      end
    end

    context "user sign in" do
      before do
        @user = create :user
        sign_in @user
        @line_item = create :line_item, user: @user
      end

      context 'not be commented' do
        it "should be comment" do
          lambda do
            post :create, line_item_id: @line_item.id, context: "xxx"
          end.should change(Comment, :count).by 1
        end
      end

      context "be commented" do
        before do
          create :comment, line_item: @line_item
        end

        it "should not be comment" do
          lambda do
            post :create, line_item_id: @line_item.id, context: "xxx"
          end.should change(Comment, :count).by 0
        end
      end
    end
  end
end
