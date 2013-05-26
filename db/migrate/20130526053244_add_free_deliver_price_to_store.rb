class AddFreeDeliverPriceToStore < ActiveRecord::Migration
  def change
    add_column :stores, :free_deliver_price, :decimal
  end
end
