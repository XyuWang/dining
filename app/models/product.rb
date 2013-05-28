class Product < ActiveRecord::Base
  attr_accessible :description, :store_id, :title, :price, :sales_colume, :avatar

  validates :description, :title, :store, :price, presence: true

  belongs_to :store
  has_many :line_items

  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"

  def can_be_ordered?
    store.opened?
  end
end
