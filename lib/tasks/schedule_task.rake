namespace  :schedule_task do
    desc 'Task for scheduling'
    task schedule_next_task: :environment do
        todays_tasks = Task.where(date: Date.today )
        todays_tasks.each do |task|
            repeat = task.repeat
            today = Date.today
            next_date = Date.today
            new_task = Task.new(name: task.name,time: task.time, repeat: task.repeat, user_id: task.user_id, employee_id: task.employee_id, category: task.category, priority: task.priority)
            case repeat
            when "Daily"
                next_date = today + 1.day
            when "Weekly"
                next_date = today + 7.days
            when "Monthly"
                next_date = today + 1.month
            when "Quarterly"
                next_date = today + 4.months
            when "Halfyearly"
                next_date = today + 6.months
            when "Yearly"
                next_date = today + 1.year
            else 
               
            end
            new_task.date = next_date 
            new_task.save!
            TaskMailer.with(user:new_task.user , task: new_task ).task_assigned.deliver_later
        end
    end

    desc 'Task for sending reminder mail and notification'
    task send_reminder_task: :environment do
        upcoming_tasks = Task.where(date: (Date.today + 1.week) )
        upcoming_tasks.each do |task|
            ReminderMailer.with(task: task, user: task.user).send_reminder.deliver_later
            user = User.find(task.employee_id)
            desc = "Reminder for the  task due on  #{task.date} . Task Name: #{ task.name } ."
            notification = user.notifications.create(task_id: task.id, desc: desc,  owner_id: task.user_id, seen: false)
        end    
    end
end