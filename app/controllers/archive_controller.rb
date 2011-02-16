class ArchiveController < ApplicationController

  # application constants
  LIBRARY_URL = "http://library.qajarwomen.org/"
  def clear_my_items

    @return_url = session[:archive_url].nil? ? archive_path : session[:archive_url]

    forget_all

    respond_to do |format|
      format.html { redirect_to @return_url }
    end

  end

  def index
    load_filter_models(true)
    @reset = true
    @my_archive_ids = my_archive_from_cookie
    #cache the current search set in a session variable
    session[:archive_url] = request.fullpath
    session[:current_items] = nil
  end

  def collections
    @filter_letter = params[:filter_letter] unless params[:filter_letter].nil? || params[:filter_letter].length > 1

    @all_collections = Collection.where(['publish=? AND private=? AND collection_translations.locale=?', true, false, I18n.locale.to_s]).order('collection_translations.sort_name')

    if @filter_letter.blank?
    @collections = @all_collections
    else
      @collections = Collection.includes("items").select('DISTINCT collection.id').where(['collections.publish=? AND private=? AND collection_translations.locale=? AND items.id IS NOT NULL AND UPPER(SUBSTRING(collection_translations.name,1,1)) = ?', true, false, I18n.locale.to_s,@filter_letter]).order('collection_translations.name')
    end
    @valid_initials = @all_collections.map { |s| s.name[0].upcase }.uniq
    @alphabet = I18n.translate(:a_z_menu).split(" ")

  end

  def collection_detail

    @return_url = session[:archive_url].nil? ? archive_path : session[:archive_url]

    @error = false
    begin
      @collection = Collection.find(params[:id])
      @items_count =  @collection.items_count
    rescue => e
      flash[:error] = e.message
    @error = true
    end

    respond_to do |format|
      unless @error
        format.html
        format.xml  { render :xml => @collection }
      else
        format.html { redirect_to(archive_collections_path) }
      end
    end

  end

  def subjects
    @return_url = (session[:archive_url].nil?) ? '/archive' : session[:archive_url]
    @filter_letter = params[:filter_letter] unless params[:filter_letter].nil? || params[:filter_letter].length > 1

    @all_subjects = Subject.includes("classifications").select('DISTINCT subjects.id').where(['subjects.publish=? AND subject_type_id = ? AND subject_translations.locale=? AND classifications.id IS NOT NULL', true, 7, I18n.locale.to_s]).order('subject_translations.name')

    if @filter_letter.blank?
    @subjects = @all_subjects
    else
      @subjects = Subject.includes("classifications").select('DISTINCT subjects.id').where(['subjects.publish=? AND subject_type_id = ? AND subject_translations.locale=? AND classifications.id IS NOT NULL AND UPPER(SUBSTRING(subject_translations.name,1,1)) = ?', true, 7, I18n.locale.to_s,@filter_letter]).order('subject_translations.name')
    end
    @valid_initials = @all_subjects.map { |s| s.name[0].upcase }.uniq
    @alphabet = I18n.translate(:a_z_menu).split(" ")

  end

  def places

    @return_url = (session[:archive_url].nil?) ? '/archive' : session[:archive_url]
    @filter_letter = params[:filter_letter] unless params[:filter_letter].nil? || params[:filter_letter].length > 1

    @all_places = Place.includes("plots").select('DISTINCT places.id').where(['places.publish=? AND place_translations.locale=? AND plots.id IS NOT NULL', true, I18n.locale.to_s]).order('place_translations.name')

    if @filter_letter.blank?
    @places = @all_places
    else
      @places = @all_places.where(['UPPER(SUBSTRING(place_translations.name,1,1)) = ?', @filter_letter])
    end

    @valid_initials = @all_places.map { |s| s.name[0].upcase }.uniq
    @alphabet = I18n.translate(:a_z_menu).split(" ")

  end

  def people

    @return_url = (session[:archive_url].nil?) ? '/archive' : session[:archive_url]
    @filter_letter = params[:filter_letter] unless params[:filter_letter].nil? || params[:filter_letter].length > 1

    @all_people = Person.includes("appearances").select('DISTINCT people.id').where(['people.publish=? AND person_translations.locale=? AND appearances.id IS NOT NULL', true, I18n.locale.to_s]).order('person_translations.name')

    if @filter_letter.blank?
    @people = @all_people
    else
      @people = @all_people.where(['UPPER(SUBSTRING(person_translations.name,1,1)) = ?', @filter_letter])
    end

    @valid_initials = @all_people.map { |s| s.name[0].upcase }.uniq
    @alphabet = I18n.translate(:a_z_menu).split(" ")

  end

  def genres

    @return_url = (session[:archive_url].nil?) ? '/archive' : session[:archive_url]
    @filter_letter = params[:filter_letter] unless params[:filter_letter].nil? || params[:filter_letter].length > 1

    @all_genres = Subject.includes("classifications").select('DISTINCT subjects.id').where(['subjects.publish=? AND subject_type_id = ? AND subject_translations.locale=? AND classifications.id IS NOT NULL', true, 8, I18n.locale.to_s]).order('subject_translations.name')

    if @filter_letter.blank?
    @genres = @all_genres
    else
      @genres = Subject.includes("classifications").select('DISTINCT subjects.id').where(['subjects.publish=? AND subject_type_id = ? AND subject_translations.locale=? AND classifications.id IS NOT NULL AND UPPER(SUBSTRING(subject_translations.name,1,1)) = ?', true, 8, I18n.locale.to_s,@filter_letter]).order('subject_translations.name')
    end

    @valid_initials = @all_genres.map { |s| s.name[0].upcase }.uniq
    @alphabet = I18n.translate(:a_z_menu).split(" ")

  end

  def browser
    
    #grab view mode, using session or default of list if not present or junky
    @view_mode = ['list','grid'].include?(params[:view_mode]) ? params[:view_mode] : session[:view_mode] || 'list'

    #grab the sort mode
    @sort_mode = ['alpha_asc','alpha_dsc','date_asc','date_dsc'].include?(params[:sort_mode]) ? params[:sort_mode] : (session[:sort_mode].blank? ? 'alpha_asc' : session[:sort_mode])
    @order = build_order_query(@sort_mode)

    # paginate the items
    @page = params[:page] ||= 1
    @per_page = params[:per_page] ||= Item.per_page ||= 100
    
    #grab filter categories
    @filters[:collection_filter] = params[:collection_filter].kind_of?(Array) ? params[:collection_filter] : [params[:collection_filter]]
    @filters[:translation_filter] = params[:translation_filter].kind_of?(Array) ? params[:translation_filter] : [params[:translation_filter]]
    @filters[:period_filter] = params[:period_filter].kind_of?(Array) ? params[:period_filter] : [params[:period_filter]]
    @filters[:person_filter] = params[:person_filter].kind_of?(Array) ? params[:person_filter] : [params[:person_filter]]
    @filters[:subject_filter] = params[:subject_filter].kind_of?(Array) ? params[:subject_filter] : [params[:subject_filter]]
    @filters[:place_filter] = params[:place_filter].kind_of?(Array) ? params[:place_filter] : [params[:place_filter]]
    
    # grab advanced search parameters
    @filters[:keyword_filter] = { :values => [ params[:keyword_filter] ], :fields => [ 'everything' ], :operators => [ ]  }
    @filters[:recent_additions_filter] = params[:recent_additions_filter]
    @filters[:year_range_filter] = {:start_year => params[:start_year_filter].to_i, :end_year => params[:end_year_filter].to_i }
    @filters[:boolean_keyword_filter] = { :values => [ params[:value_1], params[:value_2], params[:value_3] ],
      :fields => [ params[:field_1], params[:field_2], params[:field_3] ],
      :operators => [ '', params[:operator_1], params[:operator_2] ]  }

	# detect my selections filter
    @my_archive_ids = my_archive_from_cookie
    @filters[:my_archive_filter] = params[:my_archive] == 'true' ? @my_archive_ids : nil

	# contruct sql for simple filters
    @query_hash = { :conditions => ['items.publish=:publish','item_translations.locale=:locale'], :parameters => {:publish => 1, :locale => I18n.locale.to_s }, :labels => []}
    @query_hash = build_collection_query(@filters[:collection_filter], @query_hash) unless @filters[:collection_filter].nil? || @filters[:collection_filter].empty?
    @query_hash = build_period_query(@filters[:period_filter], @query_hash) unless @filters[:period_filter].nil? || @filters[:period_filter].empty?
    @query_hash = build_person_query(@filters[:person_filter], @query_hash) unless @filters[:person_filter].nil? || @filters[:person_filter].empty?
    @query_hash = build_subject_query(@filters[:subject_filter], @query_hash) unless @filters[:subject_filter].nil? || @filters[:subject_filter].empty?
    @query_hash = build_place_query(@filters[:place_filter], @query_hash) unless @filters[:place_filter].nil? || @filters[:place_filter].empty?

    @query_hash = build_boolean_keyword_query(@filters[:keyword_filter], @query_hash) unless @filters[:keyword_filter][:values][0].blank? || @filters[:keyword_filter][:values][0] == I18n.translate(:search_prompt)
    @query_hash = build_year_range_query(@filters[:year_range_filter], @query_hash) unless @filters[:year_range_filter].nil? || (@filters[:year_range_filter][:start_year] == 0 && @filters[:year_range_filter][:end_year] == 0)
    @query_hash = build_boolean_keyword_query(@filters[:boolean_keyword_filter], @query_hash) unless @filters[:boolean_keyword_filter][:values][0].blank? && @filters[:boolean_keyword_filter][:values][1].blank? && @filters[:boolean_keyword_filter][:values][2].blank?

    @query_hash = build_recent_additions_query(@filters[:recent_additions_filter], @query_hash) unless @filters[:recent_additions_filter].blank?
    @query_hash = build_translation_query(@filters[:translation_filter], @query_hash) unless @filters[:translation_filter].blank?
    @query_hash = build_my_archive_query(@filters[:my_archive_filter], @query_hash) unless @filters[:my_archive_filter].nil?

    # assemble the query from the two sql injection safe parts
    @query_conditions = ''
    @query_hash[:conditions].each do |condition|
      @query_conditions += (@query_conditions.blank? ? '': ' AND ') + condition
    end

    @query = [@query_conditions, @query_hash[:parameters]]

    @items_full_set = Item.find(:all, :select => 'id', :conditions => @query, :order => @order)
    @items = @items_full_set.paginate :per_page => @per_page, :page => @page, :order => @order

    # check for a reset condition, in which case get all
    @reset = params[:reset] == 'true' || @query_hash[:conditions].length == 2
    @item_ids = items_set(@items_full_set)
    load_filter_models(@reset)

    #build query label stack
    @query_labels = (@reset || @query_hash[:labels].empty?) ? [{:field => I18n.translate(:all_items)}] : @query_hash[:labels]

    #cache the current search set in a session variable
    session[:archive_url] = request.fullpath
    session[:current_items] = @item_ids
    session[:view_mode] = @view_mode
    session[:sort_mode] = @sort_mode
  end

  def detail
    @return_url = (session[:archive_url].nil?) ? '/archive' : session[:archive_url]
    @my_archive_ids = my_archive_from_cookie

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

  def advanced_search
    @fields = [ [I18n.translate(:everything), 'everything'],
      [I18n.translate(:title), 'title'],
      [I18n.translate(:accession_num), 'accession_num'],
      [I18n.translate(:description), 'description'],
      [I18n.translate(:transcript), 'transcript'],
      [I18n.translate(:credit), 'credit'],
      [I18n.translate(:item_id), 'item id'] ]
    @operators = [ [I18n.translate(:operator_and), "AND"], [I18n.translate(:operator_or), "OR"], [I18n.translate(:operator_not), "AND NOT"] ]
    @collections = Collection.where(['publish=?',true]).map { |c| [c.name, c.id]}.sort
    @genres = Subject.genres.where(['publish=?',true]).map { |s| [s.name, s.id]}.sort
    @repositories = Repository.where(['publish=?',true]).map { |r| [r.name, r.id]}.sort
  end

  def download
    @error = false
    begin
      @item = Item.find_by_id(params[:id])
      @file_to_send = @item.zip_path
      unless File.exists?(@file_to_send)
      #create a zip file if it is the first time
      zip_them_all = ZipThemAll.new(@file_to_send, @item.preview_paths)
      zip_them_all.zip
      end
      send_file @file_to_send, :type => "application/zip"
    rescue => error
      flash[:error] = error.message
    @error = true
    end
  end

  def email
    return true
  end

  def forget_all
    if my_archive_to_cookie([])
      flash[:notice] = I18n.translate(:my_items_were_cleared)
    else
      flash[:notice] = I18n.translate(:my_items_were_not_cleared)
    end
  end

  def forget

    id_to_forget = params[:id].to_i

    unless id_to_forget.nil?
      my_ids = my_archive_from_cookie
      my_ids.delete(id_to_forget)
      unless my_archive_to_cookie(my_ids)
        flash[:notice] = "Item could not be removed from My Archive."
      end
    else
      flash[:error] = "No item id to forget from My Archive."
    end

    respond_to do |format|
      format.html { redirect_to :back }
    end

  end

  def remember

    id_to_remember = params[:id].to_i

    unless id_to_remember.nil?
      my_ids = my_archive_from_cookie
      my_ids << id_to_remember
      unless my_archive_to_cookie(my_ids)
        flash[:notice] = "Item could not be saved to My Archive. Is you browser set to accept cookies?"
      end
    else
      flash[:error] = "No item id to remember in My Archive."
    end

    respond_to do |format|
      format.html { redirect_to :back }
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

  ################
  # QUERY BUILDERS
  ################

  def build_repository_query(filter_value, query_hash)
    if filter_value.kind_of?(Array)
    ids = filter_value
    else
      ids = [filter_value]
    end
    ids_to_find = ids.map { |id| id.to_i }.sort

    passports = Passport.where(['repository_id IN (?)', ids_to_find])
    item_ids = passports.map { |p| p.item_id }.uniq.sort

    query_hash[:conditions] << 'items.id IN (:repository_item_ids)'
    query_hash[:parameters][:repository_item_ids] = item_ids unless item_ids.blank?
    query_hash[:labels] << {:field => I18n.translate(:repository), :values => passports.map { |p| p.repository.name }.uniq.sort.join(', ') }
    return query_hash
  end

  def build_collection_query(filter_value, query_hash)

    collection_ids = filter_value.kind_of?(Array) ? filter_value.map { |id| id.to_i }.sort : [filter_value.to_i]

    collections = Collection.find(collection_ids)

    query_hash[:conditions] << 'collection_id IN (:collection_ids)'
    query_hash[:parameters][:collection_ids] = collection_ids unless collection_ids.empty?
    query_hash[:labels] << {:field => I18n.translate(:collection), :values => collections.map { |c| c.name }.uniq.sort.join(', ') }

    return query_hash
  end

  def build_subject_query(filter_value, query_hash)
    additional_query = ''

    if filter_value.kind_of?(Array)
      ids_to_find = filter_value.map { |id| id.to_i }.uniq.sort
    else
      ids_to_find = [filter_value.to_i]
    end

    begin
      selected_classifications = Classification.where(["subject_id IN (?)", ids_to_find]).all
      item_ids = selected_classifications.map { |c| c.item_id }.uniq.sort

      unless item_ids.empty?
        additional_query += "items.id IN (:subject_item_ids)"
      else
      # if the person has no items, we should kill search
        flash[:error] = "No items found. Showing all."
      end
    rescue StandardError => error
      flash[:error] = "A problem was encountered searching for subject id #{filter_value}: #{error}."
    ensure
      query_hash[:conditions] << additional_query unless additional_query.blank?
      query_hash[:parameters][:subject_item_ids] = item_ids
      query_hash[:labels] << {:field => I18n.translate(:subject), :values => selected_classifications.map { |c| c.subject.name }.uniq.sort.join(', ') }
    return query_hash
    end
  end

  def build_place_query(filter_value, query_hash)

    ids_to_find = filter_value.kind_of?(Array) ? filter_value.map { |id| id.to_i }.uniq.sort : [filter_value.to_i]

    begin
      plots = Plot.where(['place_id IN (?)', ids_to_find]).all
      item_ids = plots.map { |p| p.item_id }.uniq.sort
      unless item_ids.empty?
        query_hash[:conditions] << "items.id IN (:plot_item_ids)"
        query_hash[:parameters][:plot_item_ids] = item_ids
        query_hash[:labels] << {:field => I18n.translate(:place), :values => plots.map { |p| p.place.name }.uniq.sort.join(', ') }
      else
        flash[:error] = "No items found. Showing all."
      end
    rescue StandardError => error
      flash[:error] = "A problem was encountered searching for place id #{filter_value}: #{error}."
    else
      flash[:error] = nil
    end

    return query_hash

  end

  def build_staff_favorites_query(query_hash)
    query_hash[:conditions] << "items.favorite = :favorite"
    query_hash[:parameters][:favorite] = true
    query_hash[:labels] << {:field => I18n.translate(:staff_favorites)}
    return query_hash
  end

  def build_person_query(filter_value,query_hash)
    additional_query = ''

    people_ids = filter_value.kind_of?(Array) ? filter_value.map {|id| id.to_i }.uniq.sort : [filter_value.to_i]

    begin
      appearances = Appearance.where("person_id IN (?)", people_ids).all
      item_ids = appearances.map { |a| a.item_id }.uniq.sort
      unless item_ids.empty?
        additional_query += "items.id IN (:person_item_ids)"
      else
        flash[:error] = "No items found. Showing all."
      end
    rescue StandardError => error
      flash[:error] = "A problem was encountered searching for person id #{people_ids.join(", ")}: #{error}."
    else
      flash[:error] = nil
    end

    query_hash[:conditions] << additional_query unless additional_query.blank?
    query_hash[:parameters][:person_item_ids] = item_ids
    query_hash[:labels] << { :field => I18n.translate(:people), :values => appearances.map { |p| p.person.name }.uniq.sort.join(', ') }
    return query_hash
  end

  def build_period_query(filter_value, query_hash)

    if filter_value.kind_of?(Array)
    ids = filter_value
    else
      ids = [filter_value]
    end

    ids_to_find = ids.map { |id| id.to_i }.sort

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
      query_hash[:labels] << { :field => I18n.translate(:periods), :values => periods.map { |p| p.title }.join(', ') }
    rescue StandardError => error
      flash[:error] = "A problem was encountered searching for period ids #{filter_value}: #{error}."
    else
      flash[:error] = nil
    ensure
    return query_hash
    end
  end

  def build_year_range_query(filter_value, query_hash)
    start_year = (!filter_value[:start_year].nil?  && filter_value[:start_year] > 0 && filter_value[:start_year] < 3000) ? filter_value[:start_year] : 0
    end_year = (!filter_value[:end_year].nil?  && filter_value[:end_year] > 0  && filter_value[:end_year] < 3000) ? filter_value[:end_year] : 0
    end_year = 0 unless filter_value[:end_year] >= start_year

    if start_year > 0 && end_year > 0
      date_ranges = "(sort_year BETWEEN '#{start_year}' AND '#{end_year}')"
    elsif start_year > 0
      date_ranges = "(sort_year > '#{start_year}')"
    elsif end_year > 0
      date_ranges = "(sort_year < '#{end_year}')"
    else
      date_ranges = ''
    end
    query_hash[:conditions] << date_ranges unless date_ranges.blank?
    query_hash[:labels] << {:field => I18n.translate(:years), :values => "#{start_year.to_s} - #{end_year.to_s}"}
    return query_hash
  end

  def build_most_popular_query(filter_value, query_hash)
    additional_query = ''
    begin
      item_ids = Item.most_popular_ids(50)
      unless item_ids.empty?
        additional_query += "items.id IN (:most_popular_ids)"
      else
      # if the most popular returns no items, we should kill search
        flash[:error] = "No items found. Showing all."
      end
    rescue StandardError => error
      flash[:error] = "A problem was encountered searching for most popular items: #{error}."
    ensure
      query_hash[:conditions] << additional_query unless additional_query.blank?
      query_hash[:parameters][:most_popular_ids] = item_ids
      query_hash[:labels] << {:field => I18n.translate(:most_popular).titleize }
    return query_hash
    end
  end

  def build_recent_additions_query(filter_value, query_hash)
    additional_query = ''
    if filter_value == 'true'
      begin
        item_ids = Item.recently_added_ids(50)
        unless item_ids.empty?
          additional_query += "items.id IN (:recent_addition_ids)"
        else
        # if the most popular returns no items, we should kill search
          flash[:error] = "No items found. Showing all."
        end
      rescue StandardError => error
        flash[:error] = "A problem was encountered searching for recent additions."
      ensure
        query_hash[:conditions] << additional_query unless additional_query.blank?
        query_hash[:parameters][:recent_addition_ids] = item_ids
        query_hash[:labels] << {:field => I18n.translate(:recent_additions).titleize }
      end
    end
    return query_hash
  end

  def clean_keyword(filter_value)
    filter_value = filter_value.lstrip
    filter_value = filter_value.length > 256 ? filter_value[0..255] : filter_value
    filter_value = filter_value.upcase #locale insensitive
    filter_value = "%#{filter_value}%"
    return filter_value
  end

  def build_boolean_keyword_query(filter_value, query_hash)
    additional_query = ''
    keywords = []

    # turn keyword fields into word arrays and git rid of little words
    filter_value[:values].each_with_index do |value, index|
    # first find any quoted phrases
      keywords[index] = value.scan(/'(.+?)'|"(.+?)"|([^ ]+)/).flatten.compact.reject { |k| k == "" || k.nil? || k.length<3 }.map { |k| clean_keyword(k) } unless value.blank?
    end
    # assemble the query by field for each keyword set
    keywords.each_with_index do |values, outer_index|
    # take each keyword and build a field specific query for it
      field = filter_value[:fields][outer_index]
      outer_operator = filter_value[:operators][outer_index]
      # initialize the subqueries
      subqueries = []
      # cycle through the inner keywords with an assumed AND
      values.each_with_index do |value, inner_index|
        unless value.blank?
          # test for AND requirement
          inner_operator = inner_index > 0 ? ' OR ' : ''
          subqueries << case field
            when 'everything' then "#{inner_operator}CONCAT_WS('|', UPPER(item_translations.title), UPPER(item_translations.description), UPPER(item_translations.credit), UPPER(accession_num), CONCAT('ID',items.id)) LIKE :keyword_#{outer_index}_#{inner_index}"
            when 'title' then "#{inner_operator}UPPER(item_translations.title) LIKE :keyword_#{outer_index}_#{inner_index}"
            when 'description' then "#{inner_operator}UPPER(item_translations.description) LIKE :keyword_#{outer_index}_#{inner_index}"
            when 'transcript' then "#{inner_operator}UPPER(item_translations.transcript) LIKE :keyword_#{outer_index}_#{inner_index}"
            when 'accession_num' then "#{inner_operator}UPPER(items.accession_num) LIKE :keyword_#{outer_index}_#{inner_index}"
            when 'credit' then "#{inner_operator}UPPER(item_translations.credit) LIKE :keyword_#{outer_index}_#{inner_index}"
            when 'item_id' then "#{inner_operator}CONCAT('|',items.id,'|') LIKE :keyword_#{outer_index}_#{inner_index}"
          else "#{inner_operator}UPPER(title) LIKE :keyword_#{outer_index}_#{inner_index}"
          end
          #store the parameter in a unique key
          query_hash[:parameters]["keyword_#{outer_index}_#{inner_index}".to_sym] = value
        end
      end
      additional_query += " #{outer_operator} #{subqueries.join(' ')}" unless subqueries.empty?
    end

    query_hash[:conditions] << additional_query
    query_hash[:labels] << { :field => I18n.translate(:keyword), :values => filter_value[:values].reject { |k| k.blank? }.uniq.sort.join(', ') }
    return query_hash
  end

  def build_my_archive_query(filter_value, query_hash)
    query_hash[:conditions] << "items.id IN (:my_archive_ids)"
    query_hash[:parameters][:my_archive_ids] = filter_value.sort
    query_hash[:labels] << { :field => t(:my_archive).titleize }
    return query_hash
  end

  def build_translation_query(filter_value, query_hash)
    if filter_value == "true"
      query_hash[:conditions] << "Length(item_translations.transcript) > 0"
    else
      query_hash[:conditions] << "Length(item_translations.transcript) = 0"
    end

    query_hash[:labels] <<{ :field => I18n.translate(:translations).titleize }
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

  ###################
  # FILTER REFINEMENT
  ###################

  def find_related_genres(item_ids=[])
    my_ids = Classification.where(['item_id in (?)', item_ids]).select('subject_id').map { |c| c.subject_id }.uniq.sort
    return Subject.where(["subjects.publish=? AND subjects.subject_type_id = ? AND subject_translations.locale=? AND subjects.id IN (?)", true, 8, I18n.locale.to_s, my_ids]).order('subject_translations.name')
  end

  def find_related_subjects(item_ids=[])
    my_ids = Classification.where(['item_id in (?)', item_ids]).select('subject_id').map { |c| c.subject_id }.uniq.sort
    return Subject.where(["subjects.publish=? AND subjects.subject_type_id = ? AND subject_translations.locale=? AND subjects.id IN (?)", true, 7, I18n.locale.to_s, my_ids]).order('subject_translations.name')
  end

  def find_related_collections(item_ids=[])
    my_ids = Item.where(['items.id in (?) AND items.collection_id IS NOT NULL', item_ids]).select('collection_id').map { |c| c.collection_id }.uniq.sort
    return Collection.where(["collections.publish=? AND private = ? AND collection_translations.locale=? AND collections.id IN (?)", true, false, I18n.locale.to_s, my_ids]).order('collection_translations.name')
  end

  def find_related_people(item_ids=[])
    my_ids = Appearance.where(['item_id in (?)', item_ids]).select('person_id').map { |a| a.person_id }.uniq.sort
    return Person.where(["people.publish=? AND person_translations.locale=? AND people.id IN (?)", true, I18n.locale.to_s, my_ids]).order('person_translations.name')
  end

  def find_related_places(item_ids=[])
    my_ids = Plot.where(['item_id in (?)', item_ids]).select('place_id').map { |a| a.place_id }.uniq.sort
    return Place.where(["places.publish=? AND place_translations.locale=? AND places.id IN (?)", true, I18n.locale.to_s, my_ids]).order('place_translations.name')
  end

  def find_related_periods(item_ids=[])
    my_sort_years = Item.where(['items.id in (?)', item_ids]).select('sort_year').map { |c| c.sort_year }.uniq.sort
    periods = []
    my_sort_years.each do |year|
      Period.all.each do |period|
        periods << period if year >- period.start_at.year && year <= period.end_at.year
      end
    end
    return periods.uniq.sort_by(&:start_at)
  end

  def find_top_selection( my_objects = [])
    unless my_objects.empty? || !my_objects[0].respond_to?("items_count")
    my_objects.sort_by!(&:items_count).reverse!
    end
    my_top_objects = my_objects.shift(ARCHIVE_REFINE_RESULTS_TOP_SHOW_LIMIT)
    return my_top_objects
  end

  def load_filter_models( reset=true )
    if reset
      @genres = Subject.where(["subjects.publish=? AND subjects.subject_type_id = ? AND subject_translations.locale=?", true, 8, I18n.locale.to_s]).order('subject_translations.name')
      @people = Person.where(["people.publish = ? AND person_translations.locale = ?", true, I18n.locale.to_s]).order('person_translations.sort_name')
      @collections = Collection.where(['collections.publish=? AND collections.private = ?', true, false]).order('collection_translations.name')
      @periods = Period.where(['periods.publish=?',true]).order('periods.position')
      @places = Place.where(["places.publish=? AND place_translations.locale = ?", true, I18n.locale.to_s]).order("place_translations.name")
      @subjects = Subject.where(["subjects.publish=? AND subjects.subject_type_id = ? AND subject_translations.locale=?", true, 7, I18n.locale.to_s]).order('subject_translations.name')
    @subfilter_mode = false
    else
      @subfilter_mode = true
      # find complete lists for searching
      @genres = find_related_genres(@item_ids)
      @people =  find_related_people(@item_ids)
      @collections = find_related_collections(@item_ids)
      @places = find_related_places(@item_ids)
      @subjects = find_related_subjects(@item_ids)
      # periods always stays in order without top selections
      @periods = find_related_periods(@item_ids)
    end
    @top_genres = find_top_selection(@genres)
    @top_places = find_top_selection(@places)
    @top_subjects = find_top_selection(@subjects)
    @top_people = find_top_selection(@people)
    @top_collections = find_top_selection(@collections)
  end
end
