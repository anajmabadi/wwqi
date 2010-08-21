class ApplicationController < ActionController::Base
  protect_from_forgery
  
  #localization functions
  before_filter :set_locale
  
  #log activity
  after_filter :record_activity

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

    #reset defaults for correct locale
    # internationalizing will paginate
    WillPaginate::ViewHelpers.pagination_options[:previous_label] = I18n.t(:previous)
    WillPaginate::ViewHelpers.pagination_options[:next_label] = I18n.t(:next)
  end

  def extract_locale_from_subdomain
    parsed_locale = request.subdomains.first.to_sym
    (I18n.available_locales.include? parsed_locale) ? parsed_locale  : :en
  end

  protected

  #basis security
  def admin_required
    authenticate_or_request_with_http_basic do |user_name, password|
      user_name == 'admin' && password == 'Qajar'
    end if Rails.env == 'production' || params[:admin_http]
  end
  
  def record_activity
    @activity = Activity.new
    
    # who is doing the activity?
    @activity.session_id = session[:session_id] || 'testing' #record the session
    @activity.browser = request.env['HTTP_USER_AGENT'] || 'testing'
    @activity.ip_address = request.env['REMOTE_ADDR'] || 'testing'
    
    # what are they doing?
    @activity.action = action_name # grab this from the controller
    @activity.params = params.inspect # wrap this in an unless block if it might contain a password

    # track interesting objects for popularity, etc
    @activity.collection_id = @collection.id if @collection
    @activity.user_id = @user.id if @user
    @activity.person_id = @person.id if @person
    @activity.subject_id = @subject.id if @subject    
    @activity.subject_type_id = @subject_type.id if @subject_type     
    @activity.place_id = @place_id if @place
    @activity.period_id = @period.id if @period
    @activity.page_id = @page.id if @page && @page.class == Page     
    @activity.item_id = @item.id if @item

    @activity.success = true
    
    unless (@activity.save)
      flash[:error] = "Unable to log activity."
    end
  end
  
end
