class AddStoreEvaluatedToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :store_evaluated, :boolean, default: false
  end
end
