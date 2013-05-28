class ChangeLineItemReferable < ActiveRecord::Migration
  def up
    remove_column :line_items, :referable_id
    remove_column :line_items, :referable_type
    add_column :line_items, :cart_id, :integer
    add_column :line_items, :order_id, :integer
  end

  def down
  end
end
