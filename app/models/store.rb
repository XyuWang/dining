class Store < ActiveRecord::Base
  attr_accessible :description, :user_id, :name

  validates :description, :user, :name, presence: true

  belongs_to :user
  has_many :products

  def can_order?
    true
  end
end
