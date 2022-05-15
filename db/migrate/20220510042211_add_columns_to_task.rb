class AddColumnsToTask < ActiveRecord::Migration[6.1]
  def change
    add_column :tasks, :category, :string, default: "Not Specified"
    add_column :tasks, :status, :string, default: "Pending"
  end
end
