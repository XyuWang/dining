class AddValueToStore < ActiveRecord::Migration
  def change
    add_column :stores, :value, :integer, default: 0
    add_index :stores, :value
  end
end
