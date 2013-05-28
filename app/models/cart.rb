class Cart < ActiveRecord::Base
  attr_accessible :user_id, :store_id

  validates :user, presence: true

  has_many :line_items
  belongs_to :user
  belongs_to :store
end
