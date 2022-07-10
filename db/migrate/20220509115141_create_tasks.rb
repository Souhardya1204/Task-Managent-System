# frozen_string_literal: true

class CreateTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :tasks do |t|
      t.string :name
      t.date :date
      t.string :assign
      t.string :repeat
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
