# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# creating users
@admin = User.create!(name: "Admin", role: "admin", email: "admin@example.com", password: "admin12",
                      password_confirmation: "admin12")
@hrd = User.create!(name: "HRD", role: "hrd", email: "hrd@example.com", password: "password",
                    password_confirmation: "password")
@emp1 = User.create!(name: "Employee1", role: "employee", email: "emp1@example.com", password: "password",
                     password_confirmation: "password")
@emp2 = User.create!(name: "Employee2", role: "employee", email: "emp2@example.com", password: "password",
                     password_confirmation: "password")

# creating categories
category_arr = ["Exams", "Birthday", "Campus", "Mock Test", "Interview", "Event",
                "Hiring"]

category_arr.each do |name|
  Category.create!(name: name)
end

# creating tasks
@task1 = @admin.tasks.create!(name: "HTML-Project", employee_id: @emp1.id, priority: 1, repeat: "onetime",
                              category_id: 1)
@task2 = @admin.tasks.create!(name: "Birthday", employee_id: @hrd.id, priority: 2, repeat: "yearly", category_id: 2)
@task3 = @emp1.tasks.create!(name: "Mandala", employee_id: @emp2.id, priority: 3, repeat: "weekly")
@task4 = @hrd.tasks.create!(name: "Holiday", employee_id: @admin.id, priority: 1, repeat: "monthly")
@task5 = @admin.tasks.create!(name: "Rails Project", employee_id: @emp2.id, priority: 2, repeat: "quarterly")
@task6 = @admin.tasks.create!(name: "Kudos", employee_id: @emp1.id, priority: 3, repeat: "halfyearly")
@task7 = @admin.tasks.create!(name: "Task7", employee_id: @emp2.id, priority: 1, repeat: "yearly", category_id: 4)
@task8 = @admin.tasks.create!(name: "Task8", employee_id: @hrd.id, priority: 2, repeat: "monthly", category_id: 5)
@task9 = @emp1.tasks.create!(name: "Task9", employee_id: @admin.id, priority: 3, repeat: "weekly", category_id: 3)
@task10 = @emp2.tasks.create!(name: "Task10", employee_id: @admin.id, priority: 1, repeat: "daily")

# creating subtasks
@task1.subtasks.create!(title: "Subtask1", description: "Fix the navbar")
@task2.subtasks.create!(title: "Subtask1", description: "Buy a cake")
@task3.subtasks.create!(title: "Fix contents", description: "It's not containerize")
