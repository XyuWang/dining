class Comment < ActiveRecord::Base
  attr_accessible :line_item_id, :product_id, :context, :user_id

  default_scope order('created_at DESC')

  validates :context, :user, :product, presence: true

  belongs_to :line_item
  belongs_to :product
  belongs_to :user
end
