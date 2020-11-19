class Admin::DashboardsController < AdminController
  def index
    @notification = Notification.unread
                                .ordered_by_create
                                .page(params[:page]).per Settings.five
  end
end
