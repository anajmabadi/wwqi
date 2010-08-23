class ItemsController < ApplicationController

  before_filter :admin_required, :except => [:index, :show]
  before_filter :find_item, :only => [:show, :edit, :update, :destroy]

  # GET /items
  # GET /items.xml
  def index
    @page = params[:page] || 1
    @per_page = params[:per_page] || Item.per_page || 25
    @items = Item.paginate :all, :per_page => @per_page, :page => @page, :order => 'item_translations.title'

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @items }
    end
  end

  # GET /items/1
  # GET /items/1.xml
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @item }
    end
  end

  # GET /items/new
  # GET /items/new.xml
  def new
    @item = Item.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @item }
    end
  end

  # GET /items/1/edit
  def edit
  end

  # POST /items
  # POST /items.xml
  def create
    @item = Item.new(params[:item])
    @item.subjects = Subject.find(params[:subject_ids]) if params[:subject_ids]
    respond_to do |format|
      if @item.save
        format.html { redirect_to(@item, :notice => 'Item was successfully created.') }
        format.xml  { render :xml => @item, :status => :created, :location => @item }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /items/1
  # PUT /items/1.xml
  def update
    @item.subjects = Subject.find(params[:subject_ids]) if params[:subject_ids]
    logger.info "--------------items#update: @item.subjects.size = " + @item.subjects.size.to_s
    respond_to do |format|
      
      logger.info "------------ items#update: respond_to in progress"
      if @item.update_attributes(params[:item])
        logger.info "------------ items#update: respond_to save worked"
        format.html { redirect_to(@item, :notice => 'Item was successfully updated.') }
        format.xml  { head :ok }
      else
        logger.info "------------ items#update: respond_to else: something went wrong"
        format.html { render :action => "edit" }
        format.xml  { render :xml => @item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.xml
  def destroy
    @item.destroy

    respond_to do |format|
      format.html { redirect_to(items_url, :notice => 'Item was deleted.') }
      format.xml  { head :ok }
    end
  end
  
  private
  
  def find_item
    begin
      @item = Item.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      #TODO: Translate this field
      flash[:error] = "The item you were looking for could not be found."
      redirect_to items_path
    end
  end  
end
