require 'spec_helper'

describe Product do

  it {should validate_presence_of :description}
  it {should validate_presence_of :title}
  it {should validate_presence_of :store}
  it {should validate_presence_of :price}
  it {should belong_to :store}
  it {should have_many :line_items}
  it {should have_many :comments}

  describe "#can_be_ordered" do
    before do
      @store = create :store
      @product = create :product, store: @store
    end

    it "should return true if store is opened" do
      @store.opening!

      @product.can_be_ordered?.should == true
    end

    it "should return false if store is closed" do
      @product.can_be_ordered?.should == false
    end
  end

  it "should can't destroy the product" do
    @product = create :product
    @product.destroy.should == false
  end
end
