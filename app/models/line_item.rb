class LineItem < ActiveRecord::Base
  attr_accessible :price, :quantity, :product_id, :cart_id, :order_id, :user_id

  validates :price, :product, :quantity, :user, presence:true
  validates :price, numericality: {greater_than_or_equal_to: 0.01}
  validates :quantity, numericality:
                      {greater_than_or_equal_to: 1,
                       only_integer: true
                      }

  belongs_to :cart
  belongs_to :order
  belongs_to :product
  belongs_to :user
  has_one :comment, as: :commentable
end
