class Product < ActiveRecord::Base
  attr_accessible :description, :store_id, :title

  validates :description, :title, :store, presence: true

  belongs_to :store
  has_many :line_items, as: :referable
end
