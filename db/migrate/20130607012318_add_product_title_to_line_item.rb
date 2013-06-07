class AddProductTitleToLineItem < ActiveRecord::Migration
  def change
    add_column :line_items, :product_title, :string
  end
end
