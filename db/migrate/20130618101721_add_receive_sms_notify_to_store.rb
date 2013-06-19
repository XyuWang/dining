class AddReceiveSmsNotifyToStore < ActiveRecord::Migration
  def change
    add_column :stores, :receive_sms_notify, :boolean, default: true
  end
end
