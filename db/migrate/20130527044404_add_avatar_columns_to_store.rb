class AddAvatarColumnsToStore < ActiveRecord::Migration
  def change
    add_attachment :stores, :avatar
  end
end
