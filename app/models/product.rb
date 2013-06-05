class Product < ActiveRecord::Base
  attr_accessible :description, :store_id, :title, :price, :sales_volume, :avatar

  default_scope order('sales_volume DESC')

  validates :description, :title, :store, :price, presence: true

  belongs_to :store
  has_many :line_items
  has_many :comments
  before_destroy :decline_destroy

  has_attached_file :avatar, :styles => { :medium => "500x500>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"

  def can_be_ordered?
    store.opened?
  end

private
  def decline_destroy
    false
  end
end
