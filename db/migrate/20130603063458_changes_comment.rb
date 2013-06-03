class ChangesComment < ActiveRecord::Migration
  def up
    remove_column :comments, :commentable_id
    remove_column :comments, :commentable_type

    add_column :comments, :line_item_id, :integer
    add_column :comments, :product_id, :integer

    add_index :comments, :line_item_id
    add_index :comments, :product_id
  end

  def down
  end
end
