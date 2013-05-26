#coding: UTF-8
class Order < ActiveRecord::Base
  attr_accessible :message, :user_id, :phone, :address, :name, :store_id

  default_scope order('created_at DESC')
  
  validates :user_id, :user, :phone, :address, :state, :store, presence: true
  validate :line_items, :ensure_have_line_items
  validate :line_items, :ensure_can_be_ordered
  validate :can_deliver?

  state_machine :state, initial: :pending do
    after_transition pending: :delivered, do: :send_delivered_meessage
    after_transition pending: :closed, do: :send_closed_meessage

    event :deliver do
      transition pending: :delivered
    end

    event :close do
      transition pending: :closed
    end
  end

  belongs_to :user
  belongs_to :store
  has_many :line_items, as: :referable

  def total_price
    OrderDomain.get_total_price self
  end

  private
  def send_delivered_meessage
    line_items.each do |line_item|
      product = line_item.product
      product.sales_volume += line_item.quantity
      product.save
    end
  end

  def send_closed_meessage
  end

  def ensure_have_line_items
    if self.line_items.blank?
      errors.add :base, "请至少选择一件产品"
    end
  end

  def ensure_can_be_ordered
    line_items.each do |line_item|
      if line_item.product.can_be_ordered? == false
        errors.add :base, "不能购买此商品"
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
