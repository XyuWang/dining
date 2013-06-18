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

  describe "order" do
    let!(:user) {create :user}
    let!(:store) {create :open_store, free_deliver_price: 10}
    let!(:product_1) {create :up_product, store: store}
    let!(:product_2) {create :up_product, store: store}

    before do
      @order = Order.new user_id: user.id, store_id: store.id, phone: "111", address: "xxx"
      @order.line_items << build(:line_item, user: user, product: product_1, price: 10)
      @order.line_items << build(:line_item, user: user, product: product_2, price: 20)
      @order.save

    end

    it "order should be present" do
        @order.should be_present
      end


    context "before deliver" do
      describe "store turnover" do
        it "should be 0" do
          store.turnover.should == 0
        end
      end
    end

    context "after deliver" do
      before do
        @order.accept
        @order.deliver
      end

      describe "store turnover" do
        it "should be 30" do
          store.reload
          store.turnover.should == 30
        end
      end

      describe "product sales volumn" do
        it "should be 1" do
          product_1.reload
          product_1.sales_volume.should == 1
        end
      end
    end
  end
end
