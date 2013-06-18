class AddTurnoverToStore < ActiveRecord::Migration
  def change
    add_column :stores, :turnover, :decimal, default: 0, precision:8, scale:2
  end
end
