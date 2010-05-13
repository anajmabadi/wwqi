class CollectionsController < ApplicationController

  before_filter :admin_required, :except => [:index, :detail]

  # application constants
  LIBRARY_URL = "http://library.qajarwomen.org/"
  
  def index
    @categories = Category.find(:all, :conditions => 'publish=1', :order => 'parent_id, position')
    @major_categories = Category.find(:all, :conditions => 'publish=1 AND parent_id=id', :order => 'parent_id, position')
    @people = Person.find(:all, :conditions => 'publish=1', :order => 'person_translations.sort_name')
    @collections = Collection.find(:all, :conditions => 'publish=1', :order => 'collection_translations.sort_name, collection_translations.name')
    @periods = Period.find(:all, :conditions => 'publish=1', :order => 'position')
    @items = Item.find(:all, :conditions => 'publish=1', :order => 'items.id')

    #cache the current search set in a session variable
    query = ''
    session[:collections_url] = request.request_uri
    session[:current_items] = items_set(query)
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

  def items_set(query='')
    return Item.find(:all, :select => 'id', :conditions => query, :order => 'item_translations.title').map { |i| i.id }
  end
end
