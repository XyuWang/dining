class AddDeliverAreaToStore < ActiveRecord::Migration
  def change
    add_column :stores, :deliver_area, :text
  end
end
