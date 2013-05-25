class Store < ActiveRecord::Base
  attr_accessible :description, :user_id, :name, :state

  validates :description, :user, :name, presence: true

 state_machine :state, initial: :closed do
    event :opening do
      transition closed: :opened
    end

    event :close do
      transition opened: :closed
    end
  end



  belongs_to :user
  has_many :products
  has_many :orders
end
