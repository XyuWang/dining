class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :title
      t.text :description
      t.integer :store_id
      t.decimal :price, precision:8, scale:2

      t.timestamps
    end
  end
end
