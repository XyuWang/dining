class CreateLineItems < ActiveRecord::Migration
  def change
    create_table :line_items do |t|
      t.integer :product_id
      t.integer :referable_id
      t.string :referable_type
      t.decimal :price, precision:8, scale:2
      t.integer :quantity

      t.timestamps
    end
  end
end
