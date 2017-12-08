class NotificationsController < ApplicationController
  helper_method :alert

  def index
    @notifications = Notification.where(recipient_id: current_user.id).reverse
  end
  def link_through

  end
end
