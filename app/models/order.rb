class Order < ActiveRecord::Base
  attr_accessible :message, :user_id, :phone, :address, :name, :store_id

  validates :user_id, :user, :line_items, :phone, :address, :state, :store, presence: true


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

  def send_delivered_meessage
  end

  def send_closed_meessage
  end

  belongs_to :user
  belongs_to :store
  has_many :line_items, as: :referable
end
