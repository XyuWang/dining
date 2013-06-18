require 'spec_helper'

describe Store do
  it {should validate_presence_of :description}
  it {should validate_presence_of :name}
  it {should validate_presence_of :user}
  it {should validate_presence_of :free_deliver_price}

  describe "state" do
    let!(:store) {create :store}

    it "should eq closed" do
      store.closed?.should == true
    end

    it "should eq opened if open the store" do
      store.opening
      store.opened?.should == true
    end

    it "should eq closed if close the store" do
      store.opening
      store.close
      store.closed?.should == true
    end
  end

  describe "free_deliver_price" do
    let!(:store) {create :store}

    context "20.0" do
      it "should be valid" do
        store.free_deliver_price = 20.0
        store.should be_valid
      end
    end

    context "0.0" do
      it "should be valid" do
        store.free_deliver_price = 0.0
        store.should be_valid
      end
    end

    context "1000000" do
      it "should be valid" do
        store.free_deliver_price = 1000000
        store.should be_valid
      end
    end

    context "-1" do
      it "should be invalid" do
        store.free_deliver_price = -1
        store.should be_invalid
      end
    end

    context "-100" do
      it "should be invalid" do
        store.free_deliver_price = -100
        store.should be_invalid
      end
    end

    context "str" do
      it "should be invalid" do
        store.free_deliver_price = "str"
        store.should be_invalid
      end
    end
  end

  describe "#can_ordered?" do
    let!(:store) {create :store}

    it "should return true if store is opened" do
      store.opening
      store.can_ordered?.should == true
    end

    it "should return false if store if closed" do
      store.can_ordered?.should == false
    end
  end

  describe "#this_month_turnover" do
    let!(:user) {create :user}
    let!(:store) {create :open_store, free_deliver_price: 10}
    let!(:product_1) {create :up_product, store: store}
    let!(:product_2) {create :up_product, store: store}

    before do
      @order_1 = Order.new user_id: user.id, store_id: store.id, phone: "111", address: "xxx"
      @order_1.line_items << build(:line_item, user: user, product: product_1, price: 10)
      @order_1.line_items << build(:line_item, user: user, product: product_2, price: 20)
      @order_1.save


      @order_2 = Order.new user_id: user.id, store_id: store.id, phone: "111", address: "xxx"
      @order_2.line_items << build(:line_item, user: user, product: product_1, price: 10)
      @order_2.line_items << build(:line_item, user: user, product: product_2, price: 20)
      @order_2.save


      @order_3 = Order.new user_id: user.id, store_id: store.id, phone: "111", address: "xxx"
      @order_3.line_items << build(:line_item, user: user, product: product_1, price: 10)
      @order_3.line_items << build(:line_item, user: user, product: product_2, price: 20)
      @order_3.created_at = (Time.now - 10.year)
      @order_3.save

      @order_1.accept
      @order_1.deliver

      @order_2.accept
      @order_2.deliver

      @order_3.accept
      @order_3.deliver
    end



    it "should got 60" do
      store.reload
      store.this_month_turnover.should == 60
    end
  end
end
