class TaskEmailsJob
  @queue = :tasks_email

  def self.perform
    @users = User.all
    @users.each do |user|
      if user.tasks.where("tasks.required_date between ? and ?", Time.zone.today.at_beginning_of_day, Time.zone.today.at_end_of_week).where.not(status_id: 3).count > 0
        @tasks = user.tasks.where.not(status_id: 3)
        TaskReminderMailer.reminder_mailer(@tasks, user).deliver_now
      end
    end
  end

end
