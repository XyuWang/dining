class LineItem < ActiveRecord::Base
  attr_accessible :price, :product_id, :quantity, :referable_id, :referable_type

  validates :price, :product, :quantity, :referable, presence:true
  validates :price, numericality: {greater_than_or_equal_to: 0.01}
  validates :quantity, numericality: {greater_than_or_equal_to: 1}

  belongs_to :referable, polymorphic: true
  belongs_to :product
end
