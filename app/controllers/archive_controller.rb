class ArchiveController < ApplicationController
  
  before_filter :admin_required, :except => [:index, :detail, :slides]
  
  # application constants
  LIBRARY_URL = "http://library.qajarwomen.org/"
  def index
    @subject_types = SubjectType.find(:all, :conditions => ['subject_type_translations.locale = ?', I18n.locale.to_s])
    @periods = Period.find(:all, :conditions => ['period_translations.locale=?', I18n.locale.to_s], :order => 'start_at')
  end  

  def browser
    @categories = Category.find(:all, :conditions => 'publish=1', :order => 'parent_id, position')
    @people = Person.find(:all, :conditions => 'publish=1', :order => 'person_translations.sort_name')
    @collections = Collection.find(:all, :conditions => 'publish=1', :order => 'collection_translations.sort_name, collection_translations.name')
    @periods = Period.find(:all, :conditions => 'publish=1', :order => 'position')
    @subjects = Subject.find(:all, :conditions => "publish=1 AND subject_translations.locale='#{I18n.locale.to_s}'", :order => 'subject_translations.name')

    #grab filter categories
    @medium_filter = params[:medium_filter]
    @collection_filter = params[:collection_filter]
    @period_filter = params[:period_filter]
    @person_filter = params[:person_filter]
    @subject_filter = params[:subject_filter]
    @subject_type_filter = params[:subject_type_filter]

    #grab view mode, using session or default of list if not present or junky
    @view_mode = ['list','grid','slideshow'].include?(params[:view_mode]) ? params[:view_mode] : session[:view_mode] || 'list'

    #grab the sort mode
    @sort_mode = ['alpha_asc','alpha_dsc','date_asc','date_dsc'].include?(params[:sort_mode]) ? params[:sort_mode] : session[:sort_mode] || 'alpha_asc'
    @order = build_order_query(@sort_mode)

    @query = "items.publish=1 AND item_translations.locale = '#{I18n.locale.nil? ? ':en' : I18n.locale.to_s}'"

    # paginate the items
    @page = params[:page] || 1
    @per_page = @view_mode == 'slideshow' ? 12 : params[:per_page] || Item.per_page || 10

    @query += build_medium_query(@medium_filter) unless @medium_filter.nil? || @medium_filter == 'all'
    @query += build_collection_query(@collection_filter) unless @collection_filter.nil? || @collection_filter == 'all'
    @query += build_period_query(@period_filter) unless @period_filter.nil? || @period_filter == 'all'
    @query += build_person_query(@person_filter) unless @person_filter.nil? || @person_filter == 'all'
    @query += build_subject_query(@subject_filter) unless @subject_filter.nil? || @subject_filter == 'all'
    @query += build_subject_type_query(@subject_type_filter) unless @subject_type_filter.nil? || @subject_type_filter == 'all'

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
      raise RangeError if @item.nil?
      # we need to keep the current search items here

      #get the latest result set
      unless session[:current_items].nil? || session[:current_items].length < 1 || !session[:current_items].include?(@item.id)
        @items = Item.find(session[:current_items], :order => 'item_translations.title')
      else
        @items = Item.find(:all, :conditions => "publish=1", :order => "item_translations.title" )
        # check if the item is part of the set
        raise RangeError unless @items.include?(@item)
      end
    rescue StandardError => error
      flash[:error] = 'Item with id number ' + params[:id].to_s + ' was not found or your item set was invalid. Reload the collections page.'
      redirect_to @return_url
    end

    respond_to do |format|
      format.html
      format.xml  { render :xml => @item }
    end
  end

  # zoomify requires a custom XML file for its gallery viewer
  def slides
    @id = params[:id]
    @slides = Image.find(:all, :conditions => ['publish=1 && item_id = ?', @id], :order => :position)
    puts @slides.size unless @slides.nil?
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

  def build_medium_query(filter_value)
    additional_query = ''
    begin
      @category = Category.find_by_id(filter_value.to_i)
      additional_query += ' AND category_id IN (' + @category.query_ids.join(',') + ')'
    rescue StandardError => error
      flash[:error] = "A problem was encountered searching for medium id #{filter_value}: #{error}."
    else
      flash[:error] = nil
    ensure
      return additional_query
    end
  end

  def build_collection_query(filter_value)
    additional_query = ''
    begin
      @collection = Collection.find_by_id(filter_value.to_i)
      additional_query += ' AND collection_id = ' + @collection.id.to_s
    rescue StandardError => error
      flash[:error] = "A problem was encountered searching for collection id #{filter_value}: #{error}."
    else
      flash[:error] = nil
    ensure
      return additional_query
    end
  end

  def build_person_query(filter_value)
    additional_query = ''
    begin
      @person = Person.find_by_id(filter_value.to_i)
      @ids = @person.items.map { |p| p.id }
      unless @ids.empty?
        additional_query += " AND items.id IN (#{@ids.join(",")})"
      else
        flash[:error] = "No items found. Showing all."
        additional_query += ""
      end
    rescue StandardError => error
      flash[:error] = "A problem was encountered searching for person id #{filter_value}: #{error}."
    else
      flash[:error] = nil
    ensure
      return additional_query
    end
  end

  def build_period_query(filter_value)
    additional_query = ''
    begin
      @period = Period.find_by_id(filter_value.to_i)
      additional_query += " AND sort_date BETWEEN '#{@period.start_at.strftime("%Y-%m-%d")}' AND '#{@period.end_at.strftime("%Y-%m-%d")}'"
    rescue StandardError => error
      flash[:error] = "A problem was encountered searching for period id #{filter_value}: #{error}."
    else
      flash[:error] = nil
    ensure
      return additional_query
    end
  end

  def build_subject_query(filter_value)
    additional_query = ''
    begin
      @subject = Subject.find_by_id(filter_value.to_i)
      @ids = @subject.items.map { |p| p.id }
      unless @ids.empty? 
        additional_query += " AND items.id IN (#{@ids.join(",")})"
      else
        # if the person has no items, we should kill search
        flash[:error] = "No items found. Showing all."
        additional_query += ""
      end
    rescue StandardError => error
      flash[:error] = "A problem was encountered searching for subject id #{filter_value}: #{error}."
    ensure
      return additional_query
    end
  end
  
  def build_subject_type_query(filter_value)
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
        additional_query += " AND items.id IN (#{@ids.join(",")})"
      else
        # if the subject type has no items, we should kill search
        flash[:error] = "No items found. Showing all."
        additional_query += ""
      end
    rescue StandardError => error
      flash[:error] = "A problem was encountered searching for subject type #{filter_value.to_s}: #{error}."
    else
      flash[:error] = nil
    ensure
      return additional_query
    end
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
