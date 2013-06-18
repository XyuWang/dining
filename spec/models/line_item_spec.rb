require 'spec_helper'

describe LineItem do
  it{should validate_presence_of :price}
  it{should validate_presence_of :product}
  it{should validate_presence_of :quantity}
  it{should validate_presence_of :product_title}
  it{should validate_presence_of :user}
  it{should belong_to :cart}
  it{should belong_to :order}
  it{should belong_to :product}
  it{should belong_to :user}
  it{should have_one :comment}

  describe "price" do
    let(:line_item){create :line_item}

    context "abc" do
      it "should be invalid" do
        line_item.price = "abc"
        line_item.should be_invalid
      end
    end

    context "-100" do
      it "should be invalid" do
        line_item.price = -100
        line_item.should be_invalid
      end
    end

    context "-1" do
      it "should be invalid" do
        line_item.price = -1
        line_item.should be_invalid
      end
    end

    context "0" do
      it "should be invalid" do
        line_item.price = 0
        line_item.should be_invalid
      end
    end

    context "1" do
      it "should be valid" do
        line_item.price = 1
        line_item.should be_valid
      end
    end

    context "100" do
      it "should be valid" do
        line_item.price = 100
        line_item.should be_valid
      end
    end
  end

  describe "quantity" do
    let(:line_item){create :line_item}

    context "abc" do
      it "should be invalid" do
        line_item.quantity = "abc"
        line_item.should be_invalid
      end
    end

    context "-100" do
      it "should be invalid" do
        line_item.quantity = -100
        line_item.should be_invalid
      end
    end

    context "-1" do
      it "should be invalid" do
        line_item.quantity = -1
        line_item.should be_invalid
      end
    end

    context "0" do
      it "should be invalid" do
        line_item.quantity = 0
        line_item.should be_invalid
      end
    end

    context "1" do
      it "should be valid" do
        line_item.quantity = 1
        line_item.should be_valid
      end
    end

    context "1.5" do
      it "should be invalid" do
        line_item.quantity = 1.5
        line_item.should be_invalid
      end
    end

    context "100" do
      it "should be valid" do
        line_item.quantity = 100
        line_item.should be_valid
      end
    end
  end
end
