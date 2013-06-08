#coding: UTF-8
class Order < ActiveRecord::Base
  attr_accessible :user_id, :store_id, :phone, :address, :name, :message

  default_scope order('created_at DESC')

  validates :user_id, :user, :phone, :address, :state, :store_id, :store, presence: true
  validate :ensure_have_line_items, :ensure_can_be_ordered, :can_deliver?, on: :create

  state_machine :state, initial: :pending do
    after_transition pending: :delivered, do: :after_deliver

    event :deliver do
      transition pending: :delivered
    end

    event :close do
      transition pending: :closed
    end
  end

  belongs_to :user
  belongs_to :store
  has_many :line_items

  def total_price
    OrderDomain.get_total_price self
  end

  private
  def after_deliver
    line_items.each do |line_item|
      product = line_item.product
      product.sales_volume += line_item.quantity
      product.save
    end
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
