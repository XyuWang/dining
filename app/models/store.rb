class Store < ActiveRecord::Base
  attr_accessible :description, :user_id

  validates :description, :user, presence: true

  belongs_to :user
  has_many :products
end
