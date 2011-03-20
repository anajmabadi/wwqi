class ArchiveController < ApplicationController

  before_filter :reset_filters, :only => [:index, :collections, :genres, :subjects, :places]
  before_filter :load_recently_used_emails, :only => [:browser, :detail]
  layout :smart_layout
    	
  # layout 'full_screen', :only => [:zoomify]
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
  	@reset = true
    load_filter_models(true)
    
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
      @genres = @collection.genres
      @items_count =  @collection.items_count
      
      @collections = Collection.where(['publish=? AND private=? AND collection_translations.locale=?', true, false, I18n.locale.to_s]).order('collection_translations.sort_name')

      # first try to find three favorites
	  @collection_highlight_items = @collection.items.is_published.where('favorite = ?', true).limit(3)
	  
	  if @collection_highlight_items.empty?
	      @random_offset = @items_count > 3 ? rand(@items_count-3) : 0
		  @collection_highlight_items = @collection.items.is_published.offset(@random_offset).limit(3)
	  end
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

    @all_subjects = Subject.where(['subjects.publish=? AND subject_type_id = ? AND subject_translations.locale=? AND subjects.items_count_cache > ?', true, 7, I18n.locale.to_s, 0]).order('subject_translations.name')
	
	@filter_letter = set_filter_letter( params[:filter_letter], @all_subjects.count) 
	
    if @filter_letter.blank?
    	@subjects = @all_subjects
    else
      @subjects = @all_subjects.where(['UPPER(SUBSTRING(subject_translations.name,1,1)) = ?', @filter_letter])
    end
    @valid_initials = @all_subjects.map { |s| s.name[0].upcase }.uniq

  end

  def places

    @return_url = (session[:archive_url].nil?) ? '/archive' : session[:archive_url]

    @all_places = Place.where(['places.publish=? AND place_translations.locale=? AND places.items_count_cache > ?', true, I18n.locale.to_s, 0]).order('place_translations.name')
	
	@filter_letter = set_filter_letter( params[:filter_letter], @all_places.count) 
	
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
   
    @all_people = Person.select('DISTINCT people.id').where(['people.publish=? AND person_translations.locale=? AND people.items_count_cache > ?', true, I18n.locale.to_s,0]).order('person_translations.sort_name')
	@filter_letter = set_filter_letter( params[:filter_letter], @all_people.count) 
	
    if @filter_letter.blank?
    @people = @all_people
    else
      @people = @all_people.where(['UPPER(SUBSTRING(person_translations.sort_name,1,1)) = ?', @filter_letter])
    end

    @valid_initials = @all_people.map { |s| s.sort_name[0].upcase }.uniq
    @alphabet = I18n.translate(:a_z_menu).split(" ")

  end

  def genres

    @return_url = (session[:archive_url].nil?) ? '/archive' : session[:archive_url]
    
    @all_genres = Subject.where(['subjects.publish=? AND subject_type_id = ? AND subject_translations.locale=? AND subjects.items_count_cache > ?', true, 8, I18n.locale.to_s, 0]).order('subject_translations.name')
	@filter_letter = set_filter_letter( params[:filter_letter], @all_genres.count) 

    if @filter_letter.blank?
    @genres = @all_genres
    else
      @genres = @all_genres.where(['UPPER(SUBSTRING(subject_translations.name,1,1)) = ?', @filter_letter])
    end

    @valid_initials = @all_genres.map { |s| s.name[0].upcase }.uniq
    @alphabet = I18n.translate(:a_z_menu).split(" ")

  end
  
  def drop_filter
  	filter_name = params[:filter_name].to_sym
  	value = params[:value]
    filter_stack = session[:filter_stack]
  	
  	unless filter_name.nil? || filter_stack.nil?
  		if value.to_i != 0
  			# the search term is a simple numerical id and can be matched to a filter directly
  			filter_stack[filter_name] = filter_stack[filter_name].reject { |i| i == value.to_i }
  		elsif filter_name == :keyword_filter && !value.nil?	
			new_array = filter_stack[:keyword_filter][:values][0].reject { |i| i == value }
			if new_array.empty?
				filter_stack[:keyword_filter] = nil
			else
				filter_stack[:keyword_filter][:values][0] = new_array
			end
  		else 
  			filter_stack[filter_name] = nil 
  		end
  	end 
  	
  	# resave this as a session
  	session[:filter_stack] = filter_stack
  	
  	respond_to do |format|
    	format.html { redirect_to(archive_browser_path) }
    end
    
  end

  def browser
  	
  	#if this request was not from browser, reset all filters
  	@exclusive = params[:exclusive] == "true"
  	collection_detail_url = params[:collection_filter].nil? ? "N/A" : archive_collection_detail_url(params[:collection_filter][0].to_i) 
  	if [archive_url, archive_collections_url, collection_detail_url, archive_people_url, archive_places_url, archive_subjects_url, archive_genres_url].include?(request.referrer) || params[:my_archive] == 'true' || !params[:keyword_filter].nil? || @exclusive
  		@item_ids = nil
    	@filters = {}
    	session[:filter_stack] = nil
  	end
    
    #grab view mode, using session or default of list if not present or junky
    @view_mode = ['list','grid'].include?(params[:view_mode]) ? params[:view_mode] : session[:view_mode] || 'list'

    #grab the sort mode
    @sort_mode = ['alpha_asc','alpha_dsc','date_asc','date_dsc'].include?(params[:sort_mode]) ? params[:sort_mode] : (session[:sort_mode].blank? ? 'alpha_asc' : session[:sort_mode])
    @order = build_order_query(@sort_mode)

    # paginate the items
    @page = params[:page] ||= 1
    @per_page = @view_mode == 'grid' ? 24 : params[:per_page] ||= Item.per_page ||= 25
    
    #grab filter categories
    @filters = {}
    @filters[:collection_filter] = params[:collection_filter].kind_of?(Array) ? params[:collection_filter].map { |i| i.to_i }.uniq.sort : [ params[:collection_filter].to_i ] unless params[:collection_filter].nil?
    @filters[:period_filter] = params[:period_filter].kind_of?(Array) ? params[:period_filter].map { |i| i.to_i }.uniq.sort : [params[:period_filter].to_i] unless params[:period_filter].nil?
    @filters[:person_filter] = params[:person_filter].kind_of?(Array) ? params[:person_filter].map { |i| i.to_i }.uniq.sort : [params[:person_filter].to_i] unless params[:person_filter].nil?
    @filters[:genre_filter] = params[:genre_filter].kind_of?(Array) ? params[:genre_filter].map { |i| i.to_i }.uniq.sort : [params[:genre_filter].to_i] unless params[:genre_filter].nil?
    @filters[:subject_filter] = params[:subject_filter].kind_of?(Array) ? params[:subject_filter].map { |i| i.to_i }.uniq.sort : [params[:subject_filter].to_i] unless params[:subject_filter].nil?
    @filters[:place_filter] = params[:place_filter].kind_of?(Array) ? params[:place_filter].map { |i| i.to_i }.uniq.sort : [params[:place_filter].to_i] unless params[:place_filter].nil?

	# grab boolean flag filters
	@filters[:translation_filter] = params[:translation_filter] == 'true' unless params[:recent_additions_filter].nil?
    @filters[:recent_additions_filter] = params[:recent_additions_filter] == 'true' unless params[:recent_additions_filter].nil?
    
    # grab keyword and advanced search parameters
    @filters[:keyword_filter] = { :values => [ string_to_searchable_array(params[:keyword_filter] )], :fields => [ 'everything' ], :operators => [ ]  } unless params[:keyword_filter].nil?
    @filters[:year_range_filter] = {:start_year => params[:start_year_filter].to_i, :end_year => params[:end_year_filter].to_i, :calendar_type_id => params[:calendar_type_filter].to_i } unless params[:start_year_filter].nil? && params[:end_year_filter].nil?
    @filters[:boolean_keyword_filter] = { :values => [ string_to_searchable_array(params[:value_1]), 
    												   string_to_searchable_array(params[:value_2]), 
    												   string_to_searchable_array(params[:value_3]) ],
      :fields => [ params[:field_1], params[:field_2], params[:field_3] ],
      :operators => [ '', params[:operator_1], params[:operator_2] ]  } unless params[:value_1].nil? && params[:value_2].nil? && params[:value_3].nil?  

	# detect my selections filter
    @my_archive_ids = my_archive_from_cookie
    @filters[:my_archive_filter] = params[:my_archive] == 'true' ? @my_archive_ids : nil unless params[:my_archive].nil?
    
   	# prepend any existing searches
   	logger.info "--------- session[:filter_stack]: " + session[:filter_stack].to_s
    logger.info "--------- @filters: " + @filters.to_s
    
  	@filters = prepend_existing_filters(@filters, session[:filter_stack]) unless session[:filter_stack].nil? || params[:reset] == 'true'
  	
	# contruct sql for simple filters
    @query_hash = { :conditions => ['items.publish=:publish','item_translations.locale=:locale'], :parameters => {:publish => 1, :locale => I18n.locale.to_s }, :labels => []}
    @query_hash = build_collection_query(@filters[:collection_filter], @query_hash) unless @filters[:collection_filter].nil? || @filters[:collection_filter].empty?
    @query_hash = build_period_query(@filters[:period_filter], @query_hash) unless @filters[:period_filter].nil? || @filters[:period_filter].empty?
    @query_hash = build_person_query(@filters[:person_filter], @query_hash) unless @filters[:person_filter].nil? || @filters[:person_filter].empty?
    @query_hash = build_genre_query(@filters[:genre_filter], @query_hash) unless @filters[:genre_filter].nil? || @filters[:genre_filter].empty?
    @query_hash = build_subject_query(@filters[:subject_filter], @query_hash) unless @filters[:subject_filter].nil? || @filters[:subject_filter].empty?
    @query_hash = build_place_query(@filters[:place_filter], @query_hash) unless @filters[:place_filter].nil? || @filters[:place_filter].empty?

    @query_hash = build_boolean_keyword_query(@filters[:keyword_filter], @query_hash) unless @filters[:keyword_filter].nil? || @filters[:keyword_filter][:values].empty? || @filters[:keyword_filter][:values][0] == I18n.translate(:search_prompt)
    @query_hash = build_year_range_query(@filters[:year_range_filter], @query_hash) unless @filters[:year_range_filter].nil? || (@filters[:year_range_filter][:start_year] == 0 && @filters[:year_range_filter][:end_year] == 0)
    @query_hash = build_boolean_keyword_query(@filters[:boolean_keyword_filter], @query_hash) unless @filters[:boolean_keyword_filter].nil? || @filters[:boolean_keyword_filter][:values][0].blank? && @filters[:boolean_keyword_filter][:values][1].blank? && @filters[:boolean_keyword_filter][:values][2].blank?

    @query_hash = build_recent_additions_query(@filters[:recent_additions_filter], @query_hash) unless @filters[:recent_additions_filter].blank?
    @query_hash = build_translation_query(@filters[:translation_filter], @query_hash) unless @filters[:translation_filter].blank?
    @query_hash = build_my_archive_query(@filters[:my_archive_filter], @query_hash) unless @filters[:my_archive_filter].nil?

    # assemble the query from the two sql injection safe parts
    @query_conditions = ''
    @query_hash[:conditions].each do |condition|
      @query_conditions += (@query_conditions.blank? ? '': ' AND ') + condition
    end

    @query = [@query_conditions, @query_hash[:parameters]]

    @items_full_set = Item.where(@query).order(@order)
    @items = @items_full_set.paginate :per_page => @per_page, :page => @page

    # check for a reset condition, in which case get all
    
    @item_ids = @items_full_set.select("DISTINCT items.id").map { |i| i.id }.sort
    @reset = params[:reset] == 'true' || @query_hash[:conditions].length == 2 || params[:my_archive] == 'true'
    
    load_filter_models(@reset, @item_ids)

    #build query label stack
    @query_labels = (@reset || @query_hash[:labels].empty?) ? [{:field => I18n.translate(:all_items)}] : @query_hash[:labels]

    #cache the current search set in a session variable
    session[:archive_url] = request.fullpath
    session[:current_items] = @item_ids
    session[:view_mode] = @view_mode
    session[:sort_mode] = @sort_mode
    session[:filter_stack] = @reset ? nil : @filters
  end

  def detail
    @return_url = (session[:archive_url].nil?) ? archive_browser_path : session[:archive_url]
    @my_archive_ids = my_archive_from_cookie
    
    @zoomify_show = params[:zoomify_show] == 'true'
    @full_screen = false

    begin
    	
		    	# grab and zoomify parameters
	    @zoomify_section_id = params[:zoomify_section_id].to_i == 0 ? nil : params[:zoomify_section_id].to_i
	    
	    unless @zoomify_section_id.nil?
	    	@section = Section.find(@zoomify_section_id)
	    	@zoomify_page = @section.nil? ? 1 : @section.start_page
	    else
	    	@zoomify_page = params[:zoomify_page].to_i == 0 ? 1 : params[:zoomify_page].to_i
	    end
	    
      @item = Item.find_by_id(params[:id])
	  @sections_list = @item.sections.where('sections.publish = ?', true).order('sections.start_page').map { |s| [s.to_label, s.id]} unless @item.sections.nil? || @item.sections.empty?
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
        format.js { render :template => 'archive/reload_zoomify_pane.js.erb' }
      else
        format.html { redirect_to @return_url }
      end
    end
  end
  
  def download_pdf
  	
    @return_url = (session[:archive_url].nil?) ? archive_browser_path : session[:archive_url]
    @cover_page_only = params[:cover_page_only] == 'true'
    
    begin
      @item = Item.find_by_id(params[:id])
    rescue StandardError => error
      flash[:error] = 'Item with id number ' + params[:id].to_s + ' was not found.'
      @error = true
    end
		
    respond_to do |format|
      unless @error
        format.html 
        format.pdf do
        	html = render_to_string(:layout => 'pdf.html.erb', :template => 'archive/download_pdf.erb')
		    kit = PDFKit.new(html, :encoding => 'UTF-8', 'no-pdf-compression' => true )
		    kit.stylesheets << "#{Rails.root}/public/stylesheets/pdf.css"
		    kit.stylesheets << "#{Rails.root}/public/stylesheets/pdf_fa.css" if I18n.locale == :fa
		    #kit.to_file("#{Rails.root}/public/pdfs/it_" + @item.id.to_s + ".pdf")
		    send_data(kit.to_pdf, :filename => @item.pdf_file_name, :type => Mime::PDF)
		    return # to avoid double render call
      	end
      else
        format.html { redirect_to @return_url }
      end
    end
  end
  
  def print_friendly_transcript
  	@item = Item.find_by_id(params[:id])
  end
  
  def print_friendly_translation
  	@item = Item.find_by_id(params[:id])
  end

  def zoomify

    @return_url = (session[:archive_url].nil?) ? archive_browser_path : session[:archive_url]
    @my_archive_ids = my_archive_from_cookie
    
    @zoomify_show = false
    @full_screen = true

    begin
    	
    	# grab and zoomify parameters
	    @zoomify_section_id = params[:zoomify_section_id].to_i == 0 ? nil : params[:zoomify_section_id].to_i
	    
	    unless @zoomify_section_id.nil?
	    	@section = Section.find(@zoomify_section_id)
	    	@zoomify_page = @section.nil? ? 1 : @section.start_page
	    else
	    	@zoomify_page = params[:zoomify_page].to_i == 0 ? 1 : params[:zoomify_page].to_i
	    end
    
      @item = Item.find_by_id(params[:id])
	  @sections_list = @item.sections.where('sections.publish = ?', true).order('sections.start_page').map { |s| [s.to_label, s.id]} unless @item.sections.nil? || @item.sections.empty?

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
        format.js { render :template => 'archive/reload_zoomify_pane.js.erb' }
      else
        format.html { redirect_to @return_url }
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
    @calendar_types = CalendarType.all.map { |c| [c.name, c.id]}.sort
  end

  def download
  	@return_url = archive_detail_path(params[:id])
    @error = false
    begin
      @item = Item.find_by_id(params[:id])
      @file_to_send = @item.zip_path
      unless File.exists?(@file_to_send)
      	# find the preview files
      	files_to_zip = @item.preview_paths
      	# create a fresh cover page
      	@cover_page_only = true
  	    html = render_to_string(:action => :download_pdf, :layout => 'pdf.html.erb', :template => 'archive/download_pdf.erb')
	    kit = PDFKit.new(html, :encoding => 'UTF-8', 'no-pdf-compression' => true )
	    kit.stylesheets << "#{Rails.root}/public/stylesheets/pdf.css"
	    kit.stylesheets << "#{Rails.root}/public/stylesheets/pdf_fa.css" if I18n.locale == :fa
	    #kit.to_file("#{Rails.root}/public/pdfs/it_" + @item.id.to_s + ".pdf")
	    file_path = "#{Rails.root}/tmp/it_#{@item.id}_cover_sheet.pdf"
	    logger.info "file_path: " + file_path
	    kit.to_file(file_path)
	    files_to_zip << file_path
		#create a zip file if it is the first time
		zip_them_all = ZipThemAll.new(@file_to_send, files_to_zip)
		zip_them_all.zip
      end
      send_file @file_to_send, :type => "application/zip"
      return
    rescue => error
      flash[:error] = error.message
    	@error = true
    end
    respond_to do |format|
      unless @error
        format.html { redirect_to @return_url}
      else
        format.html { redirect_to @return_url, :flash => { :error => error.message} }
      end
    end
  end

  def email
  	@error = false	
	begin
	  	@ids = params[:ids].split(" ").map { |i| i.to_i }
	  	if @ids.size == 1
	  		@return_url = archive_detail_path(@ids[0])	
	  	elsif @ids.size > 1
	  		@return_url = session[:archive_url].nil? ? archive_browser_path : session[:archive_url]
	  	else
	   		@error = true
	  		raise "No items were passed for emailing."	
		end
		# assemble the mail file
		@from = params[:from]
		@to = params[:to]
		
		if @from.blank? || @to.blank? 
			@error = true
			raise "Email addresses invalid" 
		end
		
		# save these emails in a session
		session[:recent_from_email] = @from
		session[:recent_to_email] = @to
		
		@note = params[:note]
		@items = Item.find(@ids)
		unless @items.empty?
			citations = @items.map { |i| i.full_citation }
		    @html_citations = citations.join("<br/><br/>") 
		    @text_citations = citations.join("\n\n")
		else
			@error = true
			raise "No items found in passed email set."    	
		end
   rescue => e
   	@error = true
   	flash[:error] = e.message
   end
   
   respond_to do |format|
      unless @error    	
      	#send the citation
      	CitationMailer.email_citation(@to, @from, @note, @html_citations, @text_citations).deliver     	
        format.html { redirect_to @return_url}
        format.js 
      else
        format.html { redirect_to @return_url, :flash => { :error => I18n.translate(:email) + ": " + e.message} }
        format.js
      end
    end
  end

  def forget_all
    my_archive_to_cookie([])
  end

  def forget

    id_to_forget = params[:id].to_i

    unless id_to_forget.nil?
      my_ids = my_archive_from_cookie
      my_ids.delete(id_to_forget)
      my_archive_to_cookie(my_ids)
	end
    respond_to do |format|
		format.html { redirect_to_back(@return_url) }
	end

  end

  def remember
  	
  	@return_url = session[:archive_url] ||= archive_browser_path
	
	unless params[:ids].nil?
		ids = params[:ids].kind_of?(Array) ? params[:ids].map {|i| i.to_i } : [params[:ids].to_i]
		ids_to_remember = ids.reject {|i| i == 0 }.uniq.sort
	else
		unless params[:id].nil?
			ids_to_remember = ([params[:id].to_i]).reject {|i| i == 0 }
		end	
	end
     

    unless ids_to_remember.nil? || ids_to_remember.empty?
      my_ids = my_archive_from_cookie.nil? ? ids_to_remember : (my_archive_from_cookie | ids_to_remember)
      my_archive_to_cookie(my_ids)
    end
     
    respond_to do |format|
		format.html { redirect_to_back(@return_url) }
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

  ################
  # QUERY BUILDERS
  ################

  def build_collection_query(filter_value, query_hash)

    collection_ids = filter_value.reject { |id| id == 0 || id.nil? }

    collections = Collection.find(collection_ids)

    query_hash[:conditions] << 'collection_id IN (:collection_ids)'
    query_hash[:parameters][:collection_ids] = collection_ids unless collection_ids.empty?
    query_hash[:labels] << {:field => I18n.translate(:collection), :values => collections.map { |c| c.name }.uniq.sort.join(', ') }

    return query_hash
  end

  def build_subject_query(filter_value, query_hash)
    additional_query = ''

    ids_to_find = filter_value.reject { |id| id == 0 || id.nil? }
  
    begin
      item_ids = []
      subjects = Subject.find(ids_to_find)
      subjects.each do |subject|		
      	new_item_ids = subject.related_item_ids_cache unless subject.related_item_ids_cache.nil?
      	unless new_item_ids.nil?
      		item_ids = item_ids.empty? ? new_item_ids : item_ids & new_item_ids 
      	end
      end
      
      unless item_ids.empty?
        additional_query += "items.id IN (:subject_item_ids)"
      else
      # if the person has no items, we should kill search
        flash[:error] = "No items found. Showing all."
      end
    rescue StandardError => error
      flash[:error] = "A problem was encountered searching for subject id #{filter_value}: #{error}."
    end
      query_hash[:conditions] << additional_query unless additional_query.blank?
      query_hash[:parameters][:subject_item_ids] = item_ids.uniq.sort
      query_hash[:labels] << {:field => I18n.translate(:subject), :values => subjects.map { |c| c.name }.uniq.sort.join(', ') }
    return query_hash

  end

def build_genre_query(filter_value, query_hash)
    additional_query = ''

    ids_to_find = filter_value.reject { |id| id == 0 || id.nil? }

    begin
      item_ids = []
      subjects = Subject.find(ids_to_find)
      subjects.each do |subject|		
      	new_item_ids = subject.related_item_ids_cache unless subject.related_item_ids_cache.nil?
      	unless new_item_ids.nil?
      		item_ids = item_ids.empty? ? new_item_ids : item_ids & new_item_ids 
      	end
      end

      unless item_ids.empty?
        additional_query += "items.id IN (:genre_item_ids)"
      else
      # if the person has no items, we should kill search
        flash[:error] = "No items found. Showing all."
      end
    rescue StandardError => error
      flash[:error] = "A problem was encountered searching for genre id #{filter_value}: #{error}."
    end
	  query_hash[:conditions] << additional_query unless additional_query.blank?
	  query_hash[:parameters][:genre_item_ids] = item_ids.uniq.sort
	  query_hash[:labels] << {:field => I18n.translate(:genre), :values => subjects.map { |c| c.name }.uniq.sort.join(', ') }
	  return query_hash
  end
  
  def build_place_query(filter_value, query_hash)

    ids_to_find = filter_value.reject { |id| id == 0 || id.nil? }

    begin
   	  item_ids = []
      plots = Plot.where(['place_id IN (?)', ids_to_find])
      ids_to_find.each do |place_id|		
      	new_item_ids = plots.where("place_id = ?", place_id).all.map { |a| a.item_id }.uniq.sort 
      	unless new_item_ids.nil?
      		item_ids = item_ids.empty? ? new_item_ids : item_ids & new_item_ids 
      	end
      end
      
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

  def build_person_query(filter_value,query_hash)
    additional_query = ''

    people_ids = filter_value.reject { |id| id == 0 || id.nil? }

    begin
      item_ids = []
      appearances = Appearance.where("person_id IN (?)", people_ids)
      people_ids.each do |person_id|		
      	new_item_ids = appearances.where("person_id = ?", person_id).all.map { |a| a.item_id }.uniq.sort 
      	unless new_item_ids.nil?
      		item_ids = item_ids.empty? ? new_item_ids : item_ids & new_item_ids 
      	end
      end
      
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

    ids_to_find = filter_value.reject { |id| id == 0 || id.nil? }

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
    calendar_type_id = filter_value[:calendar_type_id] ||= 1
    
    #translate the year as needed to gregorian
    gregorian_start_year = year_by_calendar_type(start_year, calendar_type_id)   
    gregorian_end_year = year_by_calendar_type(end_year, calendar_type_id)

    if gregorian_start_year > 0 && gregorian_end_year > 0
      date_ranges = "(sort_year BETWEEN '#{start_year}' AND '#{gregorian_end_year}')"
    elsif gregorian_start_year > 0
      date_ranges = "(sort_year > '#{gregorian_start_year}')"
    elsif gregorian_end_year > 0
      date_ranges = "(sort_year < '#{gregorian_end_year}')"
    else
      date_ranges = ''
    end
    query_hash[:conditions] << date_ranges unless date_ranges.blank?
    query_hash[:labels] << {:field => I18n.translate(:years), :values => "#{start_year.to_s} - #{end_year.to_s} #{CalendarType.find(calendar_type_id).name}"}
    return query_hash
  end

  def build_recent_additions_query(filter_value, query_hash)
    additional_query = ''
    if filter_value
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
  
  def keyword_to_searchable_array(keyword_values=[])
  	keywords = []
  	keyword_values.each_with_index do |value, index|
    # first find any quoted phrases
      keywords[index] = string_to_searchable_array(value)
    end
    return keywords
  end
  
  def string_to_searchable_array(search_phrase="")
  	return search_phrase.scan(/'(.+?)'|"(.+?)"|([^ ]+)/).flatten.compact.reject { |k| k == "" || k.nil? || k.length<3 }.uniq unless search_phrase.blank?
  end

  def build_boolean_keyword_query(filter_value, query_hash)
    additional_query = ''
    
    # turn keyword fields into word arrays and git rid of little words
	keywords = @filters[:keyword_filter][:values]
	
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
          value = clean_keyword(value)
          inner_operator = inner_index > 0 ? ' AND ' : ''
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
    if filter_value
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
    my_ids = Classification.includes(['item', 'subject']).where(['classifications.item_id in (?) AND items.publish = ? AND subjects.publish = ? AND subjects.subject_type_id = ?', item_ids, true, true, 8]).select('DISTINCT classifications.subject_id').order('classifications.subject_id').map { |c| c.subject_id }
    subjects = Subject.where(["subject_translations.locale=? AND subjects.id IN (?)", I18n.locale.to_s, my_ids]).order('subject_translations.name')
  	return subjects
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

  def load_filter_models( reset = true, item_ids = [] )
	logger.info "### reset = " + reset.to_s
	@genres = Subject.where(["subjects.publish=? AND subjects.subject_type_id = ? AND subject_translations.locale=? AND subjects.items_count_cache > ?", true, 8, I18n.locale.to_s, 0]).order('subject_translations.name')
    @periods = Period.where(['periods.publish=? AND period_translations.locale = ? AND periods.items_count_cache > ? ',true, I18n.locale.to_s, 0]).order('periods.position')

  @people = Person.where(["people.publish = ? AND person_translations.locale = ? AND people.items_count_cache > ?", true, I18n.locale.to_s, 0]).order('person_translations.sort_name')
  @collections = Collection.where(['collections.publish=? AND collection_translations.locale = ? AND collections.private = ? AND collections.items_count_cache > ?', true, I18n.locale.to_s, false, 0]).order('collection_translations.name')
  @places = Place.where(["places.publish=? AND place_translations.locale = ? AND places.items_count_cache > ?", true, I18n.locale.to_s, 0]).order("place_translations.name")
  @subjects = Subject.where(["subjects.publish=? AND subjects.subject_type_id = ? AND subject_translations.locale=? AND subjects.items_count_cache > ?", true, 7, I18n.locale.to_s, 0]).order('subject_translations.name')
  @subfilter_mode = false
	unless reset
      @subfilter_mode = true
      # find complete lists for searching
      @genres = find_related_objects(@genres, item_ids, 'subjects', @filters[:genre_filter])  #find_related_genres(item_ids)
      @people =  find_related_objects(@people, item_ids, 'people', @filters[:people_filter]) #find_related_people(item_ids)
      @collections = find_related_objects(@collections, item_ids, 'collections', @filters[:collection_filter]) #(item_ids)
      @places = find_related_objects(@places, item_ids, 'places', @filters[:place_filter]) #find_related_places(item_ids)
      @subjects = find_related_objects(@subjects, item_ids, 'subjects', @filters[:subject_filter]) #find_related_subjects(item_ids)
      # periods always stays in order without top selections
      @periods = find_related_objects(@periods, item_ids, 'periods', @filters[:period_filter])
    end
    
    @top_genres = find_top_selection(@genres, @reset ? nil : item_ids) unless @genres.nil?
    @top_places = find_top_selection(@places, @reset ? nil : item_ids) unless @places.nil?
    @top_subjects = find_top_selection(@subjects, @reset ? nil : item_ids) unless @subjects.nil?
    @top_people = find_top_selection(@people, @reset ? nil : item_ids) unless @people.nil?
    @top_collections = find_top_selection(@collections, @reset ? nil : item_ids) unless @collections.nil?
  end
  
  
  def find_top_selection( my_objects = [], item_ids = nil)
  	
    unless my_objects.empty?
    	my_sorted_objects = my_objects.all.sort { |a,b| b.items_count(item_ids) <=> a.items_count(item_ids) }
    else
    	my_sorted_objects = []	
    end
    my_top_objects = my_sorted_objects.shift(ARCHIVE_REFINE_RESULTS_TOP_SHOW_LIMIT)
    return my_top_objects
  end
  
  def find_related_objects( my_objects, my_item_ids, my_type, my_filter_ids )	
  	my_original_query = my_objects
  	my_new_ids = []
  	my_objects.each do |my_object|
  		# reject an item if it has a zero count for the current set or it is on the current filter list
  		my_new_ids << my_object.id unless my_object.items_count(my_item_ids) == 0 || (!my_filter_ids.nil? && my_filter_ids.include?(my_object.id))
  	end
  	return my_original_query.where("#{my_type}.id IN (?)", my_new_ids.sort.uniq)
  end
  
  def prepend_existing_filters( filters, filter_stack = {} )
  	
  	filters[:collection_filter] = ((filter_stack[:collection_filter].nil? ? [] : filter_stack[:collection_filter]) + (filters[:collection_filter].nil? ? [] : filters[:collection_filter])).uniq
  	filters[:genre_filter] = ((filter_stack[:genre_filter].nil? ? [] : filter_stack[:genre_filter]) + (filters[:genre_filter].nil? ? [] : filters[:genre_filter])).uniq
  	filters[:subject_filter] = ((filter_stack[:subject_filter].nil? ? [] : filter_stack[:subject_filter]) + (filters[:subject_filter].nil? ? [] : filters[:subject_filter])).uniq
  	filters[:place_filter] = ((filter_stack[:place_filter].nil? ? [] : filter_stack[:place_filter]) + (filters[:place_filter].nil? ? [] : filters[:place_filter])).uniq
  	filters[:period_filter] = ((filter_stack[:period_filter].nil? ? [] : filter_stack[:period_filter]) + (filters[:period_filter].nil? ? [] : filters[:period_filter])).uniq
  	filters[:person_filter] = ((filter_stack[:person_filter].nil? ? [] : filter_stack[:person_filter]) + (filters[:person_filter].nil? ? [] : filters[:person_filter])).uniq
  	
  	filters[:translation_filter] = filters[:translation_filter] ? filters[:translation_filter] : filter_stack[:translation_filter]  
  	filters[:recent_additions_filter] = filters[:recent_additions_filter] ? filters[:recent_additions_filter] : filter_stack[:recent_additions_filter]
  	
  	# keyword filters are stored as an array of searchable strings that we should be able to add together
  	unless filter_stack[:keyword_filter].nil? && filters[:keyword_filter].nil?
  			  		new_keywords = filters[:keyword_filter].nil? || filters[:keyword_filter][:values].nil? || filters[:keyword_filter][:values].empty? ? [] : filters[:keyword_filter][:values][0] ||= []
	  		old_keywords = filter_stack[:keyword_filter].nil? || filter_stack[:keyword_filter][:values].nil? || filter_stack[:keyword_filter][:values].empty? ? [] : filter_stack[:keyword_filter][:values][0] ||= []

	  	if filters[:keyword_filter].nil?
	  		filters[:keyword_filter] = { :values => [ old_keywords ], :fields => [ 'everything' ], :operators => [ ]  }
	  	else
	  		filters[:keyword_filter][:values] = [ new_keywords | old_keywords ]
	  	end 
  	end	
  	return filters
  end
  
  def reset_filters
  	@reset = true
    @item_ids = nil
    @filters = {}
    session[:filter_stack] = nil unless session[:filter_stack].nil?
  end
  
  private 

	def smart_layout 
		full_screen_actions = ['zoomify'] 
		print_friendly_actions = ['print_friendly_transcript','print_friendly_translation']
		pdf_actions = ['download_pdf'] 
		if pdf_actions.include?(action_name)
			my_layout = 'pdf' 
		elsif full_screen_actions.include?(action_name)
			my_layout = 'full_screen' 
		elsif print_friendly_actions.include?(action_name)	
			my_layout = 'print_friendly'
		else
			my_layout = 'application' 
		end
		return my_layout
	end
	
	  def set_filter_letter(passed_filter_letter, record_count = 0)
  	@alphabet = I18n.translate(:a_z_menu).split(" ")
	# make the filter letter the first of there are more than 50
	if record_count > 50 && passed_filter_letter.nil?
		new_filter_letter = @alphabet[0]
	elsif passed_filter_letter.nil? || passed_filter_letter.length > 1
		new_filter_letter = nil
	else
		new_filter_letter = passed_filter_letter
	end
	return new_filter_letter
  end

  def load_recently_used_emails
  	@to = session[:recent_to_email]
  	@from = session[:recent_from_email]
  end
  
end
