class AddExtraValueToStore < ActiveRecord::Migration
  def change
    add_column :stores, :extra_value, :integer, default: 0
  end
end
