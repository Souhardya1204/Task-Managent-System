# frozen_string_literal: true

class CreateNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :notifications do |t|
      t.text :desc
      t.boolean :seen
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
