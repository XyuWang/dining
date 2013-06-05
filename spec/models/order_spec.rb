require 'spec_helper'

describe Order do
  it {should have_many :line_items}
  it {should belong_to :user}
  it {should belong_to :store}

  describe "#create" do
    before do
      user = create :user
      store = create :store, free_deliver_price: 10
      @order = Order.new user_id: user.id, store_id: store.id, phone: "111", address: "xxx"
    end

    context "all is correct" do
      before do
        @order.stub(:ensure_have_line_items)
        @order.stub(:ensure_can_be_ordered)
        @order.stub(:can_deliver?)
      end

      it "should create" do
        @order.save.should == true
      end

      context "user not exist" do
        it "should be invalid" do
          @order.user_id = nil
          @order.should be_invalid
        end
      end

      context "phone not exist" do
        it "should be invalid" do
          @order.phone = nil
          @order.should be_invalid
        end
      end

      context "store not exist" do
        it "should be invalid" do
          @order.store_id = nil
          @order.should be_invalid
        end
      end

      context "address not exist" do
        it "should be invalid" do
          @order.address = nil
          @order.should be_invalid
        end
      end
    end
    context 'line_item not exist' do
      before do
        @order.stub(:ensure_can_be_ordered)
        @order.stub(:can_deliver?)
      end

      it "should be invalid" do
        @order.should be_invalid
      end
    end

    context "can't be ordered" do
      before do
        @order.stub(:ensure_have_line_items)
        @order.stub(:can_deliver?)
        @order.stub(:ensure_can_be_ordered) { @order.errors.add :base, "xxx"}
      end

      it "should be invalid" do
        @order.should be_invalid
      end
    end

    context "can't be delivered" do
      before do
        @order.stub(:ensure_have_line_items)
        @order.stub(:can_deliver?){ @order.errors.add :base, "xxx"}
        @order.stub(:ensure_can_be_ordered)
      end

      it "should be invalid" do
        @order.should be_invalid
      end
    end
  end
end
