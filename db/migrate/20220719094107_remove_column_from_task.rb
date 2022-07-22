# frozen_string_literal: true

class RemoveColumnFromTask < ActiveRecord::Migration[6.1]
  def change
    remove_column :tasks, :category, :string
  end
end
