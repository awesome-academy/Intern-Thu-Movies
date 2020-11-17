class AdminController < ApplicationController
  authorize_resource User
  layout "admin"

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, alert: exception.message
  end
end
