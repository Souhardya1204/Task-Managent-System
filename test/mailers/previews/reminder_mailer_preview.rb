# Preview all emails at http://localhost:3000/rails/mailers/reminder_mailer
class ReminderMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/reminder_mailer/send_reminder
  def send_reminder
    ReminderMailer.with(task: Task.first).send_reminder
  end

end
