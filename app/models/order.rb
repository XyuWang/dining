#coding: UTF-8
class Order < ActiveRecord::Base
  attr_accessible :message, :user_id, :phone, :address, :name, :store_id

  validates :user_id, :user, :phone, :address, :state, :store, presence: true
  validate :line_items, :ensure_have_line_items

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

  private
  def send_delivered_meessage
  end

  def send_closed_meessage
  end
  
  def ensure_have_line_items
    if self.line_items.blank?
      errors.add :base, "请至少选择一件产品"
    end
  end
end
