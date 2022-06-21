class AddColumnTaskRec < ActiveRecord::Migration[6.1]
  def change
    add_column :notifications, :task_id, :integer
    add_column :notifications, :owner_id, :integer
    remove_column :notifications, :desc, :string
  end
end
