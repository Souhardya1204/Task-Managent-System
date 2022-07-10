# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version
  ruby "3.0.0"

* Database initialization
  I have kept some data in seeds.rb file , which are:
    1. An admin(email: 'admin@example.com', password: 'admin12') , a hrd (email: 'hrd@example.com', password: 'password'),
    and 2 employees.
    2. 4 tasks and 3 subtasks have already been created

* Services (job queues, cache servers, search engines, etc.)
  Active_job_queue_adaptors:
    1. sidkiq 
    2. async in production
  
  
*Testing the functionality
  1. To view mail at new task creation, remider -run sidekiq (because the method is delivery_later) and mailcatcher to visualise
  2. For scheduling task at repeated interval: bundle exec rake schedule_task:schedule_next_task. But there should be a task that matches the provided          condition.
  3. To get notification before 7 days: run bundle exec rake schedule_task:send_reminder_task. But there should be a task that matches the provided              condition.

* Deployment instructions
I have deployed the application in heroku. But using cron jobs in heroku it requires credit card information so only task scheduling and reminder notification is not working on heroku.

Deployed at: https://project-task-management-system.herokuapp.com/
* ...
