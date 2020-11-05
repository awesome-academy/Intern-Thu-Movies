class ApplicationController < ActionController::Base
  include MoviesHelper

  before_action :set_locale

  def rescue_404_exception
    render file: Rails.root.join("public", "404.html").to_s, layout: false,
                status: :not_found
  end

  private

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    {locale: I18n.locale}
  end
end
