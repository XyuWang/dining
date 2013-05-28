class LineItem < ActiveRecord::Base
  attr_accessible :price, :product_id, :quantity, :cart_id, :order_id

  validates :price, :product, :quantity, presence:true
  validates :price, numericality: {greater_than_or_equal_to: 0.01}
  validates :quantity, numericality: {greater_than_or_equal_to: 1}

  belongs_to :cart
  belongs_to :order
  belongs_to :product
  has_one :comment, as: :commentable
end
