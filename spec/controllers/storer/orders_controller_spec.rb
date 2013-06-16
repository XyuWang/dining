require 'spec_helper'

describe Storer::OrdersController do
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

  describe "#deliver" do
    let!(:user) {create :user}
    let!(:storer) {create :user}
    let!(:store){create :store, user: storer}

    before do
      @order = build :order, user: user, store: store
      @order.save(validate: false)
    end

    context "user not sign in" do
      it "should redirect to login page" do
        put :deliver, order_id: @order.id

        response.status.should == 302
        response.should redirect_to new_user_session_path
      end
    end

    context 'user sign in' do
      context "not is storer" do
        before do
          sign_in user
        end

        it "should redirect_to back" do
          put :deliver, order_id: @order.id

          response.status.should == 302
        end
      end

      context "is storer" do
        before do
          storer.roles << :storer
          storer.save
          sign_in storer
        end

        context "user have store" do
          context "order state is pending" do
            it "should not change" do

              put :deliver, order_id: @order.id

              @order.reload
              @order.should be_pending
            end
          end

          context "order state is accepted" do
            it "should change to devivered" do
              @order.accept

              put :deliver, order_id: @order.id

              @order.reload
              @order.should be_delivered
            end
          end

          context "order state is deliver" do
            before do
              @order.accept
              @order.deliver
            end

            it "should not change the state" do
              put :deliver, order_id: @order.id

              @order.reload
              @order.should be_delivered
            end
          end

          context "order state is closed" do
            before do
              @order.close!
            end

            it "should not change the state" do

              put :deliver, order_id: @order.id

              @order.reload
              @order.should be_closed
            end
          end
        end

        context "user not have store" do
          it "should redirect to storer_path" do
            put :deliver, order_id: @order.id

            response.status.should == 302
          end
        end
      end
    end
  end

  describe "#close" do
    let!(:user) {create :user}
    let!(:storer) {create :user}
    let!(:store){create :store, user: storer}

    before do
      @order = build :order, user: user, store: store
      @order.save(validate: false)
    end

    context "user not sign in" do
      it "should redirect to login page" do
        put :close, order_id: @order.id

        response.status.should == 302
        response.should redirect_to new_user_session_path
      end
    end

    context 'user sign in' do
      context "not is storer" do
        before do
          sign_in user
        end

        it "should redirect_to back" do
          put :close, order_id: @order.id

          response.status.should == 302
        end
      end

      context "is storer" do
        before do
          storer.roles << :storer
          storer.save
          sign_in storer
        end

        context "user have store" do
          context "order state is pending" do
            it "should change to devivered" do

              put :close, order_id: @order.id

              @order.reload
              @order.should be_closed
            end
          end

          context "order state is closed" do
            before do
              @order.close!
            end

            it "should not change the state" do

              put :close, order_id: @order.id

              @order.reload
              @order.should be_closed
            end
          end

          context "order state is delivered" do
            before do
              @order.accept
              @order.deliver
            end

            it "should not change the state" do

              put :close, order_id: @order.id

              @order.reload
              @order.should be_delivered
            end
          end
        end

        context "user not have store" do
          it "should redirect to storer_path" do
            put :close, order_id: @order.id

            response.status.should == 302
          end
        end
      end
    end
  end


  describe "#accept" do
    let!(:user) {create :user}
    let!(:storer) {create :user}
    let!(:store){create :store, user: storer}

    before do
      @order = build :order, user: user, store: store
      @order.save(validate: false)
    end

    context "user not sign in" do
      it "should redirect to login page" do
        put :accept, order_id: @order.id

        response.status.should == 302
        response.should redirect_to new_user_session_path
      end
    end

    context 'user sign in' do
      context "not is storer" do
        before do
          sign_in user
        end

        it "should redirect_to back" do
          put :accept, order_id: @order.id

          response.status.should == 302
        end
      end

      context "is storer" do
        before do
          storer.roles << :storer
          storer.save
          sign_in storer
        end

        context "user have store" do
          context "order state is pending" do
            it "should change to accepted" do

              put :accept, order_id: @order.id

              @order.reload
              @order.should be_accepted
            end
          end

          context "order state is closed" do
            before do
              @order.close!
            end

            it "should not change the state" do

              put :accept, order_id: @order.id

              @order.reload
              @order.should be_closed
            end
          end

          context "order state is delivered" do
            before do
              @order.accept
              @order.deliver
            end

            it "should not change the state" do

              put :accept, order_id: @order.id

              @order.reload
              @order.should be_delivered
            end
          end
        end

        context "user not have store" do
          it "should redirect to storer_path" do
            put :accept, order_id: @order.id

            response.status.should == 302
          end
        end
      end
    end
  end
end
