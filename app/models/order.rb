class Order < ActiveRecord::Base
  attr_accessible :message, :user_id

  validates :user_id, :user, :line_items, presence: true

  belongs_to :user
  has_many :line_items, as: :referable
end
