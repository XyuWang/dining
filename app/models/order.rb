#coding: UTF-8
class Order < ActiveRecord::Base
  attr_accessible :user_id, :store_id, :phone, :address, :name, :message, :total_price

  default_scope order('created_at DESC')

  validates :user_id, :user, :phone, :address, :state, :store_id, :store, :total_price, presence: true
  validate :ensure_have_line_items, :ensure_can_be_ordered, :can_deliver?, on: :create

  validates :total_price, numericality:{
    greater_than_or_equal_to: 0}

  state_machine :state, initial: :pending do
    after_transition any => :delivered, do: :after_deliver

    event :deliver do
      transition accepted: :delivered
    end

    event :accept do
      transition pending: :accepted
    end

    event :close do
      transition pending: :closed
    end
  end

  scope :pending, where(state: "pending")
  scope :deliver, where(state: "delivered")
  scope :after, lambda { |time| where("created_at > ?", time)}

  belongs_to :user
  belongs_to :store
  has_many :line_items

  before_save :set_total_price

  private
  def set_total_price
    self.total_price = OrderDomain.get_total_price self
  end

  def after_deliver
    line_items.each do |line_item|
      product = line_item.product
      product.sales_volume += line_item.quantity
      product.save
    end

    store = self.store
    store.turnover += self.total_price
    store.save
  end

  def ensure_have_line_items
    if line_items.blank?
      errors.add :base, "请至少选择一件产品"
    end
  end

  def ensure_can_be_ordered
    line_items.each do |line_item|
      if line_item.product.can_be_ordered? == false
        errors.add :base, "不能购买#{line_item.product.title}"
      end
    end
  end

  def can_deliver?
    total_price =  OrderDomain.get_total_price self
    money = self.store.free_deliver_price - total_price
    if money > 0
      errors.add :base, "还差#{money}元才能送货"
    end
  end
end
