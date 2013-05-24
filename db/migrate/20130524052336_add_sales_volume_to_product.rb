class AddSalesVolumeToProduct < ActiveRecord::Migration
  def change
    add_column :products, :sales_volume, :integer, default: 0
  end
end
