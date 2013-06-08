require 'spec_helper'

describe Storer::ProductsController do
  describe "#index" do
    let!(:user) {create :user}

    context "user not sign in" do
      it "should redirect to login page" do
        get :index

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
          get :index

          response.status.should == 302
        end
      end

      context "is storer" do
        before do
          user.roles << :storer
          user.save
        end

        context "user have store" do
          let!(:store) {create :store, user: user}

          it "should response successful" do
            get :index

            response.status.should == 200
          end
        end

        context "user not have store" do
          it "should redirect to storer_path" do
            get :index

            response.status.should == 302
          end
        end
      end
    end
  end

  describe "#new" do
    let!(:user) {create :user}

    context "user not sign in" do
      it "should redirect to login page" do
        get :new

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
          get :new

          response.status.should == 302
        end
      end

      context "is storer" do
        before do
          user.roles << :storer
          user.save
        end

        context "user have store" do
          let!(:store) {create :store, user: user}

          it "should response successful" do
            get :index

            response.status.should == 200
          end
        end

        context "user not have store" do
          it "should redirect to storer_path" do
            get :index

            response.status.should == 302
          end
        end
      end
    end
  end

  describe "#show" do
    let!(:user) {create :user}
    let!(:product) {create :product}

    context "user not sign in" do
      it "should redirect to login page" do
        get :show, id: product.id

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
          get :show, id: product.id

          response.status.should == 302
        end
      end

      context "is storer" do
        before do
          user.roles << :storer
          user.save
        end

        context "user have store" do
          let!(:store) {create :store, user: user}

          it "should response successful" do
            get :index

            response.status.should == 200
          end
        end

        context "user not have store" do
          it "should redirect to storer_path" do
            get :index

            response.status.should == 302
          end
        end
      end
    end
  end

  describe  "#up" do
    let!(:user) {create :user}
    let!(:product) {create :product}

    context "user not sign in" do
      it "should redirect to login page" do
        put :up, id: product.id

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
          put :up, id: product.id

          response.status.should == 302
        end
      end

      context "is storer" do
        before do
          user.roles << :storer
          user.save
        end

        context "user have store" do
          let!(:store) {create :store, user: user}
          let!(:product) {create :product, store: store}

          context "product state is down" do
            it "should up the product" do

              put :up, id: product.id

              product.reload
              product.should be_up
            end
          end

          context "product state is up" do
            it "should not change state" do
              product.up!

              put :up, id: product.id

              product.reload
              product.should be_up
            end
          end
        end

        context "user not have store" do
          it "should redirect to storer_path" do
            put :up, id: product.id

            response.status.should == 302
          end
        end
      end
    end
  end

  describe "#down" do
    let!(:user) {create :user}
    let!(:product) {create :product}

    context "user not sign in" do
      it "should redirect to login page" do
        put :down, id: product.id

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
          put :down, id: product.id

          response.status.should == 302
        end
      end

      context "is storer" do
        before do
          user.roles << :storer
          user.save
        end

        context "user have store" do
          let!(:store) {create :store, user: user}
          let!(:product) {create :open_product, store: store}

          context "product state is up" do
            it "should down the product" do

              put :down, id: product.id

              product.reload
              product.should be_down
            end
          end

          context "product state is down" do
            it "should not change state" do
              product.down!

              put :down, id: product.id

              product.reload
              product.should be_down
            end
          end
        end

        context "user not have store" do
          it "should redirect to storer_path" do
            put :down, id: product.id

            response.status.should == 302
          end
        end
      end
    end
  end
end
