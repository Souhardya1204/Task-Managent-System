# README

**Ruby version**:
  ruby "3.0.0" <br/>
**Rails version**:
  "rails", "~> 6.1.0"<br/>
**Database initialization**: <br/>
  I have kept some data in seeds.rb file , which are:<br/>
    1. An admin(email: 'admin@example.com', password: 'admin12') , a hrd (email: 'hrd@example.com', password: 'password'),
    and 2 employees.<br/>
    2. 4 tasks and 3 subtasks have already been created

**Services (job queues, cache servers, search engines, etc.)**</br>
  Active_job_queue_adaptors:</br>
    1. sidkiq <br/>
    2. async in production
  
  
**Testing the functionality**<br/>
  1. To view mail at new task creation, remider - run sidekiq (because the method is delivery_later) and mailcatcher to visualise<br/>
  2. For scheduling task at repeated interval: bundle exec rake schedule_task:schedule_next_task. But there should be a task that matches the provided          condition.</br>
  3. To get notification before 7 days: run bundle exec rake schedule_task:send_reminder_task. But there should be a task that matches the provided              condition.

**Deployment instructions**<br/>
I have deployed the application in heroku. But using cron jobs in heroku it requires credit card information so only task scheduling and reminder notification is not working on heroku.<br/>

Deployed at: https://project-task-management-system.herokuapp.com/
* ...
