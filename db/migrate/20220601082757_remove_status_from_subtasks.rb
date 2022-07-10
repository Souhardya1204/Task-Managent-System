class RemoveStatusFromSubtasks < ActiveRecord::Migration[6.1]
  def change
    remove_column :subtasks, :status
    add_column :subtasks, :complete, :boolean, default: false
  end
end
