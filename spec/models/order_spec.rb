require 'spec_helper'

describe Order do
  it {should validate_presence_of :user}
  it {should validate_presence_of :phone}
  it {should validate_presence_of :address}
  it {should validate_presence_of :state}
  it {should validate_presence_of :store}
  it {should have_many :line_items}
  it {should belong_to :user}
  it {should belong_to :store}

  describe "state" do
    let!(:order) { create :order}

    it "should eq pending" do
      order.should be_pending
    end

    it "should deliver the order" do
      order.deliver
      order.should be_delivered
    end

    it "should close the order" do
      order.close
      order.should be_closed
    end
  end

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
    end

    context 'line_item not exist' do
      it "should be invalid" do
        @order.should be_invalid
      end
    end

    context "line_item exist" do
      before do
        line_item = create :line_item, order: @order, price: 100
        line_item.stub_chain(:product, :can_be_ordered?)
      end
    end
  end
end
