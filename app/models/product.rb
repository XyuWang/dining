class Product < ActiveRecord::Base
  attr_accessible :description, :store_id, :title, :price, :sales_colume

  validates :description, :title, :store, :price, presence: true

  belongs_to :store
  has_many :line_items, as: :referable

  def can_be_ordered?
    store.opened?
  end
end
