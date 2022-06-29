# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
@admin = User.create!( name: 'Admin', role: 'admin', email: 'admin@example.com', password: 'admin12', password_confirmation: 'admin12')
@hrd = User.create!(name: 'HRD', role: 'hrd', email: 'hrd@example.com', password: 'password', password_confirmation: 'password')
@emp1 = User.create!(name: 'Employee1', role: 'employee', email: 'emp1@example.com', password: 'password', password_confirmation: 'password')
@emp2 = User.create!(name: 'Employee2', role: 'employee', email: 'emp2@example.com', password: 'password', password_confirmation: 'password')

# @admin = User.find_by(role: 'admin')
# @hrd = User.find_by(role: 'hrd')
# @emp1 = User.find_by(name: 'Employee1')
# @emp2 = User.find_by(name: 'Employee2')

@task1 = @admin.tasks.create!(name: "Project1", employee_id: @emp1.id, priority: 1 , repeat: "Onetime")
@task2 = @admin.tasks.create!(name: "Birthday", employee_id: @hrd.id, priority: 2 , repeat: "Yearly")
@task3 = @emp1.tasks.create!(name: "Mandala", employee_id: @emp2.id, priority: 1 , repeat: "Onetime")
@task4 = @hrd.tasks.create!(name: "Holiday", employee_id: @admin.id, priority: 2 , repeat: "Onetime")

@task1.subtasks.create!(title: "Subtask1", description: "Fix the navbar")
@task2.subtasks.create!(title: "Subtask1", description: "Buy a cake")
@task3.subtasks.create!(title: "Fix contents", description: "It's not containerize" )