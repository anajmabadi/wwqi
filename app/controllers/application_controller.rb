class ApplicationController < ActionController::Base
  protect_from_forgery
  
  #localization functions
  before_filter :set_locale
  before_filter :get_my_archive_items
  
  #log activity
  # after_filter :record_activity
  
  def get_my_archive_items
  	@my_archive_ids = my_archive_from_cookie
  end

  # csv generation code
  def make_custom_csv(collection)
    csv_string = CSV.generate do |csv|
        # header row
        if collection[0].respond_to?('csv_fields')
          fields = collection[0].csv_fields ||= collection[0].attribute_names
        else
          fields = collection[0].attribute_names
          unless collection[0].translations.nil?
            fields += collection[0].translations.columns
          end
        end
        csv << fields
        
        # data rows
        collection.each do |record|
          values = fields.map { |field| record.send(field) if record.respond_to?(field) }
          csv << values
        end
      end
      return csv_string
  end
  
  #column sorting code
  def sort_order(default)
    "#{(params[:c] || default.to_s).gsub(/[\s;'\"]/,'')} #{params[:d] == 'down' ? 'DESC' : 'ASC'}"
  end

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
  
  # my archive management routines
  def my_archive_from_cookie
    # initialize the cookie store if nil?
    if cookies[:my_archive].nil?
      my_archive_to_cookie
    end
    return cookies[:my_archive].split(",").map{ |i| i.to_i }
  end
  
  def my_archive_to_cookie(my_ids=[])
    cookies.permanent[:my_archive] = my_ids.join(",")
    return my_ids == my_archive_from_cookie
  end

  # translate years to correct date by celendar type
  def year_by_calendar_type(input_year = 1900, input_calendar_type_id=1)
  	begin
	    output_year = case input_calendar_type_id
	    when 1 then input_year
	    when 2 then Calendar.gregorian_from_absolute(Calendar.absolute_from_islamic(1,1,input_year))[2]
	    when 3 then Calendar.gregorian_from_absolute(Calendar.absolute_from_jalaali(1,1,input_year))[2]
	    else input_year
	    end
	rescue => error
		flash[:error] = "An error occurred translating the date from calendar type " + input_calendar_type_id.to_s	+ ": " + error.message
  		output_year = input_year 
  	end	
  	return output_year
  end
  
  protected

  #basis security
  def admin_required
    authenticate_or_request_with_http_basic do |user_name, password|
      user_name == 'Editor2011' && password == 'Q@j@r2011'
    end if Rails.env == 'production' || params[:admin_http]
  end
  
  def record_activity
    # only record archive actions
    if params[:controller] == 'archive' && Rails.env != 'development'
      @activity = Activity.new

      # who is doing the activity?
      @activity.session_id = session[:_qajar_session][:session_id] || 'testing' #record the session
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
  
end
