#coding: UTF-8
class Order < ActiveRecord::Base
  attr_accessible :user_id, :store_id, :phone, :address, :name, :message, :total_price, :sms_status

  default_scope order('created_at DESC')

  validates :user_id, :user, :phone, :address, :state, :store_id, :store, :total_price, presence: true
  validate :ensure_have_line_items, :ensure_can_be_ordered, :can_deliver?, on: :create

  validates :total_price, numericality:{
    greater_than_or_equal_to: 0}

  state_machine :state, initial: :pending do
    after_transition any => :delivered, do: :after_deliver
    after_transition any => :accepted, do: :after_accepted

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

  before_create :set_total_price
  after_create :notify_storer

  private
  def set_total_price
    self.total_price = OrderDomain.get_total_price self
  end

  def notify_storer
    if self.store.receive_sms_notify?
      content = "有#{total_price}元订单下达，请尽快接受，详寻官网"
      SMS.new.send(self.store.user.phone, content)
    end
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

  def after_accepted
    content = "您预订的 #{line_items.map(&:product_title).join(" ")},总计#{total_price}元，商家已经开始制作，稍等哦，在此期间请保持手机畅通 ^_^"

    self.sms_status = SMS.new.send(phone, content)
    self.save
  end

  def ensure_have_line_items
    if line_items.blank?
      errors.add :base, "请至少选择一件产品"
    end
  end

  def ensure_can_be_ordered
    line_items.each do |line_item|
      if line_item.product.can_be_ordered? == false
        errors.add :base, "不能购买#{line_item.product.title}, 卖家已休息，不接受新订单"
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
