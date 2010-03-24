class CategorizationsController < ApplicationController

  before_filter :admin_required, :except => [:index, :show]

  # GET /categorizations
  # GET /categorizations.xml
  def index
    @categorizations = Categorization.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @categorizations }
    end
  end

  # GET /categorizations/1
  # GET /categorizations/1.xml
  def show
    @categorization = Categorization.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @categorization }
    end
  end

  # GET /categorizations/new
  # GET /categorizations/new.xml
  def new
    @categorization = Categorization.new
    @categories = category_list
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @categorization }
    end
  end

  # GET /categorizations/1/edit
  def edit
    @categorization = Categorization.find(params[:id])
    @categories = category_list
  end

  # POST /categorizations
  # POST /categorizations.xml
  def create
    @categorization = Categorization.new(params[:categorization])
    @categories = category_list
    respond_to do |format|
      if @categorization.save
        format.html { redirect_to(@categorization, :notice => 'Categorization was successfully created.') }
        format.xml  { render :xml => @categorization, :status => :created, :location => @categorization }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @categorization.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /categorizations/1
  # PUT /categorizations/1.xml
  def update
    @categorization = Categorization.find(params[:id])
    @categories = category_list
    respond_to do |format|
      if @categorization.update_attributes(params[:categorization])
        format.html { redirect_to(@categorization, :notice => 'Categorization was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @categorization.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /categorizations/1
  # DELETE /categorizations/1.xml
  def destroy
    @categorization = Categorization.find(params[:id])
    @categorization.destroy

    respond_to do |format|
      format.html { redirect_to(categorizations_url) }
      format.xml  { head :ok }
    end
  end

  def category_list
    return Category.find(:all, :order => "parent_id, position").map { |g| [g.name, g.id]}
  end
end
