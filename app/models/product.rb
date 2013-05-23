class Product < ActiveRecord::Base
  attr_accessible :description, :store_id, :title, :price

  validates :description, :title, :store, :price, presence: true

  belongs_to :store
  has_many :line_items, as: :referable
end
