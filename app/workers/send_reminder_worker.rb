class SendReminderWorker
    include Sidekiq::Worker
    def perform(task)
      ReminderMailer.with(task: task).send_reminder.deliver_later() # calls the mailer we made's method and delivers the email immediately
    end
  end