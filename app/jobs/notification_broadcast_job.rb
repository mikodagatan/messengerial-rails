# class NotificationBroadcastJob < ApplicationJob
#
#   @queue = :notification_broadcast
#
#    def perform(notification)
#      ActionCable.server.broadcast 'notification_channel', message: render_event(notificaiton)
#    end
#
#    private
#
#    def render_notification(notification)
#      ApplicationController.renderer.render(partial: 'notifications/number', locals: { notification: notification })
#    end
# end
