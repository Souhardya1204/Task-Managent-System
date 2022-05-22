class TaskMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.task_mailer.task_assigned.subject
  #
  def task_assigned
    @greeting = "Hi"
    @user = params[:user]
    @task = params[:task]
    mail(
      from: @user.email,
      to: User.find_by(id: @task.employee_id).email, 
      subject: "New Task assigned"
    )
  end
end
