# frozen_string_literal: true

class RemoveAssignFromTasks < ActiveRecord::Migration[6.1]
  def change
    remove_column :tasks, :assign
    add_column :tasks, :employee_id, :integer
  end
end
