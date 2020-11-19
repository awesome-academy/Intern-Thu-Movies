class NotificationsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "notifications_channel_#{params[:admin_id]}"
  end

  def unsubscribed; end
end
