# frozen_string_literal: true

class AddTimeToTask < ActiveRecord::Migration[6.1]
  def change
    add_column :tasks, :time, :time
  end
end
