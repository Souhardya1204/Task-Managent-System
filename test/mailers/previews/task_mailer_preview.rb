# Preview all emails at http://localhost:3000/rails/mailers/task_mailer
class TaskMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/task_mailer/task_assigned
  def task_assigned
    TaskMailer.with(user: User.first, task: Task.first).task_assigned
  end

end
