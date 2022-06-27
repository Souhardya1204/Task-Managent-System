class AddDescToNotifications < ActiveRecord::Migration[6.1]
  def change
    add_column :notifications, :desc, :text
  end
end
