class AddSmsStatusToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :sms_status, :string
  end
end
