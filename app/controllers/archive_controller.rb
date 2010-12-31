class ArchiveController < ApplicationController

  # application constants
  LIBRARY_URL = "http://library.qajarwomen.org/"
  def index
    @subject_type = SubjectType.find(8)
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
    @subjects = Subject.where(['publish=? AND subject_type_id = ? AND subject_translations.locale=?', 1, 7, I18n.locale.to_s]).order('subject_translations.name')
  end

  def places
    @places = Place.where(['publish=? AND place_translations.locale=?', 1, I18n.locale.to_s]).order('place_translations.name')
  end

  def people
    @people = Person.where(['publish=? AND person_translations.locale=?', 1, I18n.locale.to_s]).order('person_translations.name')
  end

  def browser
    logger.info 'browser'
    @subject_type = SubjectType.find(8)
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
    @view_mode = ['list','grid'].include?(params[:view_mode]) ? params[:view_mode] : session[:view_mode] || 'list'

    #grab the sort mode
    @sort_mode = ['alpha_asc','alpha_dsc','date_asc','date_dsc'].include?(params[:sort_mode]) ? params[:sort_mode] : (session[:sort_mode].blank? ? 'alpha_asc' : session[:sort_mode])
    @order = build_order_query(@sort_mode)

    # paginate the items
    @page = params[:page] || 1
    @per_page = @view_mode == 'slideshow' ? 12 : params[:per_page] || Item.per_page || 10

    @query_hash = { :conditions => ['items.publish=:publish','item_translations.locale=:locale'], :parameters => {:publish => 1, :locale => I18n.locale.to_s } }

    @collection_filter_label = I18n.translate(:all)
    @period_filter_label = I18n.translate(:all)
    @subject_filter_label = I18n.translate(:all)

    @query_hash = build_medium_query(@medium_filter, @query_hash) unless @medium_filter.nil? || @medium_filter == 'all'
    @query_hash = build_collection_query(@collection_filter, @query_hash) unless @collection_filter.nil? || @collection_filter[0] == 'all'
    @query_hash = build_period_query(@period_filter, @query_hash) unless @period_filter.nil? || @period_filter[0] == 'all'
    @query_hash = build_person_query(@person_filter, @query_hash) unless @person_filter.nil? || @person_filter == 'all'
    @query_hash = build_subject_query(@subject_filter, @query_hash) unless @subject_filter.nil? || @subject_filter[0] == 'all'
    @query_hash = build_place_query(@place_filter, @query_hash) unless @place_filter.nil? || @place_filter == 'all'
    @query_hash = build_subject_type_query(@subject_type_filter, @query_hash) unless @subject_type_filter.nil? || @subject_type_filter[0] == 'all'
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

  def download

    @return_url = (session[:archive_url].nil?) ? '/archive' : session[:archive_url]
    @error = false
    
    begin
      @item = Item.find_by_id(params[:id])
      @file_to_send = @item.zip_path
      unless File.exists?(@file_to_send)
        #create a zip file if it is the first time
        zip_them_all = ZipThemAll.new(@item.zip_path, @item.preview_paths)
        zip_them_all.zip
      end
      send_file @file_to_send, :type=>"application/zip"
    rescue => error
      flash[:error] = error.message
    end
  end

  # zoomify requires a custom XML file for its gallery viewer
  def slides
    @id = params[:id]
    @item = Item.find(@id)
    begin
      @slides = @item.images.where(['publish=?', true]).order('position')
    rescue => error
      flash[:error] = error.message
    ensure
    # no slides found so create some
      if @slides.empty?
      @slides = @item.create_images
      end
    end
    unless @id.nil? || @slides.nil? || @slides.empty?
      respond_to do |format|
        format.xml
      end
    else
      flash[:error] = 'Unable to locate process slides for id number ' + params[:id].to_s + '.'
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
    if filter_value.kind_of?(Array)
    ids = filter_value
    else
      ids = [filter_value]
    end
    ids_to_find = ids.map { |id| id.to_i }.sort

    if ids_to_find.length == 1
    @collection_filter_label = Collection.find(ids_to_find[0].to_i).name
    else
    @collection_filter_label = I18n.translate(:multiple)
    end

    query_hash[:conditions] << 'collection_id IN (:collection_ids)'
    query_hash[:parameters][:collection_ids] = ids_to_find unless ids_to_find.blank?
    return query_hash
  end

  def build_subject_query(filter_value, query_hash)
    additional_query = ''

    if filter_value.kind_of?(Array)
      ids_to_find = filter_value.map { |id| id.to_i }.sort
      if ids_to_find.length == 1
      @subject_filter_label = Subject.find(ids_to_find[0].to_i).name
      else
      @subject_filter_label = I18n.translate(:multiple)
      end
    else
      ids_to_find = [filter_value.to_i]
    end

    begin
      selected_subjects = Subject.find(ids_to_find)
      item_ids = []
      selected_subjects.each do |subject|
        item_ids += subject.items.map { |p| p.id }
      end

      unless item_ids.empty?
        additional_query += "items.id IN (#{item_ids.join(",")})"
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

    if filter_value.kind_of?(Array)
    ids = filter_value
    else
      ids = [filter_value]
    end

    ids_to_find = ids.map { |id| id.to_i }.sort

    if ids_to_find.length == 1
    @period_filter_label = Period.find(ids_to_find[0].to_i).title
    else
    @period_filter_label = I18n.translate(:multiple)
    end

    begin
      periods = Period.find(ids_to_find)
      if periods.size == 1
        date_ranges = "(sort_year BETWEEN '#{periods[0].start_at.strftime("%Y")}' AND '#{periods[0].end_at.strftime("%Y")}')"
      else
        date_ranges = ''
        periods.each_with_index do |period, index|
          date_ranges += "(sort_year BETWEEN '#{period.start_at.strftime("%Y")}' AND '#{period.end_at.strftime("%Y")}')"
          if index + 1 != periods.size
            date_ranges += " OR "
          end
        end
      end
      query_hash[:conditions] << date_ranges

    rescue StandardError => error
      flash[:error] = "A problem was encountered searching for period ids #{filter_value}: #{error}."
    else
      flash[:error] = nil
    ensure
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

    #check if the value is an array, or make it one
    subject_type_ids = filter_value.kind_of?(Array) ? filter_value : [filter_value]

    #turn parameter strings into proper integers for id finding
    ids_to_find = subject_type_ids.map { |id| id.to_i }.uniq.sort

    # initialize the query string
    additional_query = ''

    begin

    # get the request subjects types
      subject_types = SubjectType.find(ids_to_find)

      logger.info "subject_types.size: " + subject_types.size.to_s

      # harvest their items by looping through them
      classifications = []

      subject_types.each do |subject_type|
        classifications += subject_type.classifications(:select => 'item_id')
      end

      logger.info "classifictions.size " + classifications.size.to_s

      item_ids = classifications.map { |i| i.item_id }.uniq.sort
      logger.info "item_ids: " + item_ids.to_s

      unless item_ids.empty?
        additional_query += "items.id IN (#{item_ids.join(",")})"
        logger.info "additional_query: " + additional_query
      else
      # if the subject type has no items, we should kill search
        additional_query += "items.id IS NULL"
        flash[:error] = "No items found. Showing all."
      end

      # build the label needed for the filter display
      @subject_type_filter_label = subject_type_ids.length == 1 ? subject_types[0].name : I18n.translate(:multiple)

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
      when 'date_asc' then 'items.sort_year, items.sort_month, items.sort_day'
      when 'date_dsc' then 'items.sort_year DESC, items.sort_month DESC, items.sort_day DESC'
    else 'item_translations.locale, item_translations.title'
    end
    return additional_sort
  end

end
