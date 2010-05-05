class ApplicationController < ActionController::Base
  protect_from_forgery

  #localization functions
  before_filter :set_locale

  def set_locale
    if Rails.env.test? || request.subdomains.first.nil?
      if params[:locale] && I18n.available_locales.include?(params[:locale].to_sym)
        cookies['locale'] = { :value => params[:locale], :expires => 1.year.from_now }
        I18n.locale = params[:locale].to_sym
      elsif cookies['locale'] && I18n.available_locales.include?(cookies['locale'].to_sym)
        I18n.locale = cookies['locale'].to_sym
      end
    else
      I18n.locale = extract_locale_from_subdomain
    end
  end

  def extract_locale_from_subdomain
    parsed_locale = request.subdomains.first.to_sym
    (I18n.available_locales.include? parsed_locale) ? parsed_locale  : nil
  end

  protected

  #basis security
  def admin_required
    authenticate_or_request_with_http_basic do |user_name, password|
      user_name == 'admin' && password == 'Qajar'
    end if Rails.env == 'production' || params[:admin_http]
  end
end
