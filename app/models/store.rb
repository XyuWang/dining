class Store < ActiveRecord::Base
  attr_accessible :description, :user_id, :name, :state, :free_deliver_price

  validates :description, :user, :name, :free_deliver_price, presence: true
  validate :free_deliver_price, numericality: {greater_than_or_equal_to: 0}

 state_machine :state, initial: :closed do
    event :opening do
      transition closed: :opened
    end

    event :close do
      transition opened: :closed
    end
  end
  
  def can_ordered?
    opened?
  end

  belongs_to :user
  has_many :products
  has_many :orders

end
