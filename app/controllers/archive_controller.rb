class ArchiveController < ApplicationController
  
  # application constants
  LIBRARY_URL = "http://library.qajarwomen.org/"
  def index
    @subject_types = SubjectType.find(:all, :include => :subjects, :conditions => ['subject_type_translations.locale = ?', I18n.locale.to_s])
    @periods = Period.find(:all, :conditions => ['period_translations.locale=?', I18n.locale.to_s], :order => 'start_at')
    @random_collection_set = Collection.random_set
    @recently_viewed_items = Item.recently_viewed(8)
    
    #cache the current search set in a session variable
    session[:archive_url] = request.fullpath
    session[:current_items] = nil
  end

  def collections
    @collections = Collection.where(['publish=? AND private=? AND collection_translations.locale=?', 1, 0, I18n.locale.to_s]).order('collection_translations.sort_name')
  end

  def subjects
    @subject_types = SubjectType.where(['publish=? AND subject_type_translations.locale=?', 1, I18n.locale.to_s]).order('subject_type_translations.name')
  end

  def places
    @places = Place.where(['publish=? AND place_translations.locale=?', 1, I18n.locale.to_s]).order('place_translations.name')
  end

  def people
    @people = Person.where(['publish=? AND person_translations.locale=?', 1, I18n.locale.to_s]).order('person_translations.name')
  end

  def browser
    logger.info 'browser'
    @subject_types = SubjectType.find(:all, :conditions => 'publish=1')
    @people = Person.find(:all, :conditions => "items_count > 0 AND people.publish = 1 AND person_translations.locale = '#{I18n.locale.to_s}'", :order => 'person_translations.sort_name')
    @collections = Collection.find(:all, :conditions => 'collections.publish=1', :order => 'collection_translations.sort_name, collection_translations.name')
    @periods = Period.find(:all, :conditions => 'periods.publish=1', :order => 'periods.position')
    @places = Place.find(:all, :conditions => "places.publish=1 AND items_count > 0 AND place_translations.locale = '#{I18n.locale.to_s}'")
    @subjects = Subject.find(:all, :conditions => "subjects.publish=1 AND subjects.subject_type_id = 7 AND subjects.items_count > 0 AND subject_translations.locale='#{I18n.locale.to_s}'", :order => 'subject_translations.name')

    #grab filter categories
    @collection_filter = params[:collection_filter]
    @period_filter = params[:period_filter]
    @person_filter = params[:person_filter]
    @subject_filter = params[:subject_filter]
    @subject_type_filter = params[:subject_type_filter]
    @place_filter = params[:place_filter]
    @keyword_filter = params[:keyword_filter]
    @most_popular_filter = params[:most_popular_filter]
    @recent_additions_filter = params[:recent_additions_filter]
    @staff_favorites_filter = params[:staff_favorites_filter]

    #grab view mode, using session or default of list if not present or junky
    @view_mode = ['list','grid','slideshow'].include?(params[:view_mode]) ? params[:view_mode] : session[:view_mode] || 'list'

    #grab the sort mode
    @sort_mode = ['alpha_asc','alpha_dsc','date_asc','date_dsc'].include?(params[:sort_mode]) ? params[:sort_mode] : session[:sort_mode] || 'alpha_asc'
    @order = build_order_query(@sort_mode)

    # paginate the items
    @page = params[:page] || 1
    @per_page = @view_mode == 'slideshow' ? 12 : params[:per_page] || Item.per_page || 10

    
    @query_hash = { :conditions => ['items.publish=:publish','item_translations.locale=:locale'], :parameters => {:publish => 1, :locale => I18n.locale.to_s } }
    
    @query_hash = build_medium_query(@medium_filter, @query_hash) unless @medium_filter.nil? || @medium_filter == 'all'
    @query_hash = build_collection_query(@collection_filter, @query_hash) unless @collection_filter.nil? || @collection_filter[0] == 'all'
    @query_hash = build_period_query(@period_filter, @query_hash) unless @period_filter.nil? || @period_filter == 'all'
    @query_hash = build_person_query(@person_filter, @query_hash) unless @person_filter.nil? || @person_filter == 'all'
    @query_hash = build_subject_query(@subject_filter, @query_hash) unless @subject_filter.nil? || @subject_filter == 'all'
    @query_hash = build_place_query(@place_filter, @query_hash) unless @place_filter.nil? || @place_filter == 'all'
    @query_hash = build_subject_type_query(@subject_type_filter, @query_hash) unless @subject_type_filter.nil? || @subject_type_filter == 'all'
    @query_hash = build_keyword_query(@keyword_filter, @query_hash) unless @keyword_filter.blank? || @keyword_filter == I18n.translate(:search_prompt)
    @query_hash = build_most_popular_query(@most_popular_filter, @query_hash) unless @most_popular_filter.blank?
    @query_hash = build_recent_additions_query(@recent_additions_filter, @query_hash) unless @recent_additions_filter.blank?
    @query_hash = build_staff_favorites_query(@query_hash) unless @staff_favorites_filter.blank?
     
    # assemble the query from the two sql injection safe parts
    @query_conditions = ''
    @query_hash[:conditions].each do |condition|
      @query_conditions += (@query_conditions.blank? ? '': ' AND ') + condition
    end  
    
    @query = [@query_conditions, @query_hash[:parameters]]

    @items = Item.paginate :conditions => @query, :per_page => @per_page, :page => @page, :order => @order
    @items_full_set = Item.find(:all, :select => 'id', :conditions => @query, :order => @order)
    
    #cache the current search set in a session variable
    session[:archive_url] = request.fullpath
    session[:current_items] = items_set(@items_full_set)
    session[:view_mode] = @view_mode
    session[:sort_mode] = @sort_mode
  end

  def detail
    @return_url = (session[:archive_url].nil?) ? '/archive' : session[:archive_url]

    begin
      @item = Item.find_by_id(params[:id])

      #check if there is a current results set (i.e. something from the browser)
      unless session[:current_items].nil? || session[:current_items].length < 1 || !session[:current_items].include?(@item.id)
        @items = Item.find(session[:current_items], :order => 'item_translations.title')
      else
        @sort_mode = ['alpha_asc','alpha_dsc','date_asc','date_dsc'].include?(params[:sort_mode]) ? params[:sort_mode] : session[:sort_mode] || 'alpha_asc'
        @order = build_order_query(@sort_mode)
        @items = Item.find(:all, :conditions => "items.publish=1 AND item_translations.locale = '#{I18n.locale.to_s}'", :order => @order )
      end 
    rescue StandardError => error
      flash[:error] = 'Item with id number ' + params[:id].to_s + ' was not found or your item set was invalid. Reload the collections page.'
      @error = true
    end

    respond_to do |format|
      unless @error
        format.html
        format.xml  { render :xml => @item }
      else
        redirect_to @return_url
      end
    end
  end

  # zoomify requires a custom XML file for its gallery viewer
  def slides
    @id = params[:id]
    @slides = Image.find(:all, :conditions => ['publish=1 && item_id = ?', @id], :order => :position)
    unless @id.nil? || @slides.nil? || @slides.empty?
      respond_to do |format|
        format.xml
      end
    else
      flash[:error] = 'Unable to locate process slides for with id number ' + params[:id].to_s + '.'
    end

  end

  private

  def items_set(items)
    return items.map { |i| i.id }
  end

  def build_medium_query(filter_value, query_hash)
    additional_query = ''
    begin
      @category = Category.find_by_id(filter_value.to_i)
      additional_query += 'category_id IN (' + @category.query_ids.join(',') + ')'
    rescue StandardError => error
      flash[:error] = "A problem was encountered searching for medium id #{filter_value}: #{error}."
    else
      flash[:error] = nil
    ensure
      query_hash[:conditions] << additional_query unless additional_query.blank?
      return query_hash
    end
  end

  def build_collection_query(filter_value, query_hash)
    logger.info "build_collection_query: " + filter_value.to_s

    if filter_value.kind_of?(Array)
      ids = filter_value
    else
      ids = [filter_value]
    end
    additional_parameter = ids.map { |id| id.to_i }.sort


    logger.info "additional_parameter: " + additional_parameter.to_s

    query_hash[:conditions] << 'collection_id IN (:collection_ids)'
    query_hash[:parameters][:collection_ids] = additional_parameter unless additional_parameter.blank?
    return query_hash
    
  end
  
  def build_place_query(filter_value, query_hash)
    additional_query = ''
    begin
      @place = Place.find_by_id(filter_value.to_i)
      @ids = @place.items.map { |p| p.id }
      unless @ids.empty?
        additional_query += "items.id IN (#{@ids.join(",")})"
      else
        flash[:error] = "No items found. Showing all."
      end
    rescue StandardError => error
      flash[:error] = "A problem was encountered searching for place id #{filter_value}: #{error}."
    else
      flash[:error] = nil
    ensure
      query_hash[:conditions] << additional_query unless additional_query.blank?
      return query_hash
    end
  end
  
  def build_staff_favorites_query(query_hash)
    query_hash[:conditions] << "items.favorite = 1"
    return query_hash
  end

  def build_person_query(filter_value,query_hash)
    additional_query = ''
    begin
      @person = Person.find_by_id(filter_value.to_i)
      @ids = @person.items.map { |p| p.id }
      unless @ids.empty?
        additional_query += "items.id IN (#{@ids.join(",")})"
      else
        flash[:error] = "No items found. Showing all."
      end
    rescue StandardError => error
      flash[:error] = "A problem was encountered searching for person id #{filter_value}: #{error}."
    else
      flash[:error] = nil
    ensure
      query_hash[:conditions] << additional_query unless additional_query.blank?
      return query_hash
    end
  end

  def build_period_query(filter_value, query_hash)
    additional_query = ''
    begin
      @period = Period.find_by_id(filter_value.to_i)
      additional_query += "(sort_date BETWEEN '#{@period.start_at.strftime("%Y-%m-%d")}' AND '#{@period.end_at.strftime("%Y-%m-%d")}')"
    rescue StandardError => error
      flash[:error] = "A problem was encountered searching for period id #{filter_value}: #{error}."
    else
      flash[:error] = nil
    ensure
      query_hash[:conditions] << additional_query unless additional_query.blank?
      return query_hash
    end
  end

  def build_subject_query(filter_value, query_hash)
    additional_query = ''
    begin
      @subject = Subject.find_by_id(filter_value.to_i)
      @ids = @subject.items.map { |p| p.id }
      unless @ids.empty?
        additional_query += "items.id IN (#{@ids.join(",")})"
      else
        # if the person has no items, we should kill search
        flash[:error] = "No items found. Showing all."
      end
    rescue StandardError => error
      flash[:error] = "A problem was encountered searching for subject id #{filter_value}: #{error}."
    ensure
      query_hash[:conditions] << additional_query unless additional_query.blank?
      return query_hash
    end
  end
  
  def build_most_popular_query(filter_value, query_hash)
    additional_query = ''
    begin
      @ids = Item.most_popular_ids(50)
      unless @ids.empty?
        additional_query += "items.id IN (#{@ids.join(",")})"
      else
        # if the most popular returns no items, we should kill search
        flash[:error] = "No items found. Showing all."
      end
    rescue StandardError => error
      flash[:error] = "A problem was encountered searching for most popular items: #{error}."
    ensure
      query_hash[:conditions] << additional_query unless additional_query.blank?
      return query_hash
    end
  end
  
  def build_recent_additions_query(filter_value, query_hash)
    additional_query = ''
    begin
      @ids = Item.recently_added_ids(50)
      unless @ids.empty?
        additional_query += "items.id IN (#{@ids.join(",")})"
      else
        # if the most popular returns no items, we should kill search
        flash[:error] = "No items found. Showing all."
      end
    rescue StandardError => error
      flash[:error] = "A problem was encountered searching for recent additions."
    ensure
      query_hash[:conditions] << additional_query unless additional_query.blank?
      return query_hash
    end
  end
  
  def build_subject_type_query(filter_value, query_hash)
    logger.info("build_subject_type_query")
    additional_query = ''
    begin
      @subject_type = SubjectType.find_by_id(filter_value.to_i)
      @subjects = @subject_type.subjects
      @ids = []
      
      @subjects.each do |subject|
        @ids = @ids.concat(subject.items.map { |p| p.id })
      end
      
      @ids = @ids.sort.uniq
        
      unless @ids.empty?
        additional_query += "items.id IN (#{@ids.join(",")})"
      else
        # if the subject type has no items, we should kill search
        flash[:error] = "No items found. Showing all."
      end
    rescue StandardError => error
      flash[:error] = "A problem was encountered searching for subject type #{filter_value.to_s}: #{error}."
    else
      flash[:error] = nil
    ensure
      query_hash[:conditions] << additional_query unless additional_query.blank?
      return query_hash
    end
  end
  
  def build_keyword_query(filter_value, query_hash)
    additional_query = ''
    filter_value = filter_value.lstrip
    filter_value = filter_value.length > 256 ? filter_value[0..255] : filter_value
    filter_value = filter_value.upcase #locale insensitive
    filter_value = "%#{filter_value}%"
    # ucase if it English
    if I18n.locale == :en
      additional_query += "CONCAT_WS('|', UPPER(item_translations.title), UPPER(item_translations.description), UPPER(accession_num), CONCAT('ID',items.id)) LIKE :keyword" unless filter_value.blank?
    else
      additional_query += "CONCAT_WS('|',item_translations.title, item_translations.description, accession_num, items.id) LIKE :keyword" unless filter_value.blank?
    end
    
    query_hash[:conditions] << additional_query
    query_hash[:parameters][:keyword] = filter_value
    return query_hash
  end

  def build_order_query(sort_mode)
    additional_sort = ''
    additional_sort += case sort_mode
    when 'alpha_asc' then 'item_translations.locale, item_translations.title'
    when 'alpha_dsc' then 'item_translations.locale, item_translations.title DESC'
    when 'date asc' then 'items.sort_date'
    when 'date dsc' then 'items.sort_date DESC'
    else 'item_translations.locale, item_translations.title'
    end
    return additional_sort
  end
  
end
