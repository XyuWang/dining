class CreateCarousels < ActiveRecord::Migration
  def change
    create_table :carousels do |t|
      t.string :message
      t.integer :sequence, default: 0

      t.timestamps
    end

    add_attachment :carousels, :image
    add_index :carousels, :sequence
  end
end
