module SessionsHelper
  def log_in user
    session[:user_id] = user.id
  end

  def current_user
    @current_user ||= User.find_by id: session[:user_id] if session[:user_id]
  end

  def logged_in?
    current_user.present?
  end

  def log_out
    session.delete :user_id
    @current_user = nil
  end

  def logged_in_user
    return if logged_in?

    flash[:danger] = t ".please_login"
    redirect_to login_path
  end

  def admin_user?
    current_user&.admin?
  end
end