# frozen_string_literal: true

class AddPriorityToTask < ActiveRecord::Migration[6.1]
  def change
    add_column :tasks, :priority, :int
  end
end
