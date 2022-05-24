class ReminderMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.reminder_mailer.send_reminder.subject
  #
  def send_reminder
    @greeting = "Hi"
    @task = params[:task]
    puts params[:task].name
    mail(to: User.find_by(id: @task.employee_id).email, subject: "Reminder for assigned task")
  end
end
