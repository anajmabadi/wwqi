class Admin::CollectionsController < Admin::AdminController

  #  caches_action :index, :detail, :slides,
  #  :cache_path => Proc.new { |c| c.params.delete_if { |k,v| k.starts_with?('utm_') } },
  #  :expires_in => 4.hours,
  #  :unless => Proc.new { |c| c.request.xml_http_request? }
    
  # GET /collections
  # GET /collections.xml
  def index
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
        format.html { redirect_to(admin_collection_url(@collection), :notice => 'Collection was successfully created.') }
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
        format.html { redirect_to(admin_collection_url(@collection), :notice => 'Collection was successfully updated.') }
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
    
    begin
      @collection = Collection.find(params[:id])
      # clear the items cache to avoid mistaken restrictions on dependent records
      @items = @collection.items(true)
      # now destroy the collection
      @collection.destroy
    rescue => e
      flash[:error] = e.message
    end
    
    respond_to do |format|
      format.html { redirect_to(admin_collections_url) }
      format.xml  { head :ok }
    end
  end
  
end
