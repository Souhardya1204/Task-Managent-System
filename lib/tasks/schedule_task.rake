namespace  :schedule_task do
    desc 'Task for scheduling'
    task schedule_next_task: :environment do
        todays_tasks = Task.where(date: Date.today )
        todays_tasks.each do |task|
            repeat = task.repeat
            today = Date.today
            next_date = Date.today
            new_task = Task.new(name: task.name, repeat: task.repeat, user_id: task.user_id, employee_id: task.employee_id, category: task.category, priority: task.priority)
            case repeat
            when "Daily"
                next_date = today + 1.day
                puts(next_date)
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
            
        end
    end
end