# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2022_05_25_052523) do
  
  create_table "tasks", charset: "utf8mb3", force: :cascade do |t|
    t.string "name"
    t.date "date"
    t.string "repeat"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "employee_id"
    t.string "category", default: "Not Specified"
    t.string "status", default: "Pending"
    t.string "acceptance", default: "Pending"
    t.integer "priority"
    t.index ["user_id"], name: "index_tasks_on_user_id"
  end

  create_table "users", charset: "utf8mb3", force: :cascade do |t|
    t.string "email", null: false
    t.string "password_digest"
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "role", default: "employee"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "tasks", "users"
end
