class NotificationBroadcastJob < ApplicationJob
  queue_as :default

   def perform(notification)
     ActionCable.server.broadcast 'notification_channel', message: render_event(event)
   end

   private

   def render_notification(notification)
     ApplicationController.renderer.render(partial: 'notifications/number', locals: { notification: notification })
   end
end
