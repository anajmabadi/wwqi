class CollectionsController < ApplicationController

  before_filter :admin_required, :except => [:index, :detail, :slides]

  #  caches_action :index, :detail, :slides,
  #  :cache_path => Proc.new { |c| c.params.delete_if { |k,v| k.starts_with?('utm_') } },
  #  :expires_in => 4.hours,
  #  :unless => Proc.new { |c| c.request.xml_http_request? }

  # application constants
  LIBRARY_URL = "http://library.qajarwomen.org/"
  
  def index
    @categories = Category.find(:all, :conditions => 'publish=1', :order => 'parent_id, position')
    @major_categories = Category.find(:all, :conditions => 'publish=1 AND parent_id=id', :order => 'parent_id, position')
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
    
    @query = 'publish=1'
    @query_params = []

    # paginate the items
    @page = params[:page] || 1
    @per_page = params[:per_page] || Item.per_page || 10

    @query += build_medium_query(@medium_filter) unless @medium_filter.nil? || @medium_filter == 'all'
    @query += build_collection_query(@collection_filter) unless @collection_filter.nil? || @collection_filter == 'all'
    @query += build_period_query(@period_filter) unless @period_filter.nil? || @period_filter == 'all'
    @query += build_person_query(@person_filter) unless @person_filter.nil? || @person_filter == 'all'
    @query += build_subject_query(@subject_filter) unless @subject_filter.nil? || @subject_filter == 'all'


    @items = Item.paginate :conditions => @query, :per_page => @per_page, :page => @page, :order => 'item_translations.title'
    @items_full_set = Item.find(:all, :select => 'id', :conditions => @query, :order => 'item_translations.title')

    #cache the current search set in a session variable
    session[:collections_url] = request.fullpath
    session[:current_items] = items_set(@items_full_set)
  end

  def detail
    @return_url = (session[:collections_url].nil?) ? '/collections' : session[:collections_url]

    begin
      @item = Item.find_by_id(params[:id])
      raise RangeError if @item.nil?
      # we need to keep the current search items here

      #get the latest result set
      unless session[:current_items].nil? || session[:current_items].length < 1 || !session[:current_items].include?(@item.id)
        @items = Item.find(session[:current_items], :order => 'item_translations.title')
      else
        @items = Item.find(:all, :conditions => "publish=1 AND gallery=1", :order => "item_translations.title" )
        # check if the item is part of the set
        raise RangeError unless @items.include?(@item)
      end
    rescue StandardError => error
      flash[:error] = 'Item with id number ' + params[:id].to_s + ' was not found or your item collection was invalid.'
      redirect_to @return_url
    end


    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @collections }
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

  # GET /collections
  # GET /collections.xml
  def list
    @collections = Collection.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @collections }
    end
  end

  # GET /collections/1
  # GET /collections/1.xml
  def show
    @collection = Collection.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @collection }
    end
  end

  # GET /collections/new
  # GET /collections/new.xml
  def new
    @collection = Collection.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @collection }
    end
  end

  # GET /collections/1/edit
  def edit
    @collection = Collection.find(params[:id])
  end

  # POST /collections
  # POST /collections.xml
  def create
    @collection = Collection.new(params[:collection])

    respond_to do |format|
      if @collection.save
        format.html { redirect_to(@collection, :notice => 'Collection was successfully created.') }
        format.xml  { render :xml => @collection, :status => :created, :location => @collection }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @collection.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /collections/1
  # PUT /collections/1.xml
  def update
    @collection = Collection.find(params[:id])

    respond_to do |format|
      if @collection.update_attributes(params[:collection])
        format.html { redirect_to(@collection, :notice => 'Collection was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @collection.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /collections/1
  # DELETE /collections/1.xml
  def destroy
    @collection = Collection.find(params[:id])
    @collection.destroy

    respond_to do |format|
      format.html { redirect_to(collections_url) }
      format.xml  { head :ok }
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
        # if the person has no items, we should kill search
        additional_query += " AND isNull(items.id)"
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
        additional_query += " AND isNull(items.id)"
      end
    rescue StandardError => error
      flash[:error] = "A problem was encountered searching for period id #{filter_value}: #{error}."
    else
      flash[:error] = nil
    ensure
      return additional_query
    end
  end
end
