class TaskReminderMailer < ApplicationMailer

  include ApplicationHelper

  def reminder_mailer(tasks, user)
    @tasks = tasks
    @user = user
    mail(to: @user.email, subject: "Your Task Reminder, " + better_date2(Time.zone.today))
  end
end
