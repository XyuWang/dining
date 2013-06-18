class AddTotalPriceToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :total_price, :decimal, default: 0, precision:8, scale:2
  end
end
