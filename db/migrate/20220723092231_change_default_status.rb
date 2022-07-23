# frozen_string_literal: true

class ChangeDefaultStatus < ActiveRecord::Migration[6.1]
  def change
    change_column_default :tasks, :status, "pending"
  end
end
