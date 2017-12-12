class NotificationsController < ApplicationController
  helper_method :alert

  def index
    @notifications = Notification.where(recipient_id: current_user.id).reverse
  end

  def update_notification_unread
    @job = params[:job]
    @notification = params[:notification]
    Notification.find(@notification).update(read: Time.zone.today)
    redirect_to your_tasks_url +  "#job_first_#{@job_id}"
  end

  def update_notification_unread_all
    Notification.where( recipient_id: current_user, read: nil).update(read: Time.zone.today)
    redirect_to notifications_index_url
  end
end
