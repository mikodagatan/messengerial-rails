class NotificationsController < ApplicationController
  helper_method :alert

  def index
    @notifications = Notification.where(recipient_id: current_user.id).reverse_order
  end

  def update_notification_unread
    @task = params[:task]
    @notification = params[:notification]
    Notification.find(@notification).update(read: Time.zone.today)
    redirect_to your_tasks_url +  "#task_first_#{@task_id}"
  end

  def update_notification_unread_all
    Notification.where( recipient_id: current_user, read: nil).update(read: Time.zone.today)
    redirect_to notifications_index_url
  end
end
