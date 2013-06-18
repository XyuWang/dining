class Store < ActiveRecord::Base
  attr_accessible :name, :description, :state, :user_id, :free_deliver_price, :avatar, :turnover

  validates :name, :description, :user, :free_deliver_price, presence: true
  validates :free_deliver_price, numericality: {greater_than_or_equal_to: 0}

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
  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"

  def can_ordered?
    opened?
  end

  def to_s
    name
  end

  def this_month_turnover
    time = DateTime.new(Time.now.year, Time.now.month, 1)
    orders = self.orders.deliver.after time
    orders.sum(:total_price)
  end
end
