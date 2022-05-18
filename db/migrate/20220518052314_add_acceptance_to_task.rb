class AddAcceptanceToTask < ActiveRecord::Migration[6.1]
  def change
    add_column :tasks, :acceptance, :string, default: "Pending"
  end
end
