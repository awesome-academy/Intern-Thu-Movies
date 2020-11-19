class Admin::NotificationsController < AdminController
  def index
    @notification = Notification.ordered_by_create
                                .page(params[:page]).per Settings.ten
  end

  def read_all
    status_read = Notification.statuses[:read]
    Notification.unread.update_all status: status_read

    redirect_to admin_notifications_path
  end
end
