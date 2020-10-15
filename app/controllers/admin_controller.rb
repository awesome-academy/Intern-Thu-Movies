class AdminController < ApplicationController
  before_action :check_admin?
  layout "admin"

  private

  def check_admin?
    redirect_to root_path unless admin_user?
  end
end