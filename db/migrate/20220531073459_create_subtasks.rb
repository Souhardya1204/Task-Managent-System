class CreateSubtasks < ActiveRecord::Migration[6.1]
  def change
    create_table :subtasks do |t|
      t.string :title
      t.text :description
      t.string :status, default: "Pending"
      t.references :task, null: false, foreign_key: true

      t.timestamps
    end
  end
end
