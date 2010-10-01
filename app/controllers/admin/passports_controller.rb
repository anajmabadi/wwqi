class Admin::PassportsController < Admin::AdminController

  include ActionView::Helpers::TextHelper
  
  # GET /passports
  # GET /passports.xml
  def index
    @passports = Passport.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @passports }
    end
  end

  # GET /passports/1
  # GET /passports/1.xml
  def show
    @passport = Passport.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @passport }
    end
  end

  # GET /passports/new
  # GET /passports/new.xml
  def new

    # get the select box data
    @items = items_list
    @repositories = repositories_list

    #initialize a passport
    @passport = Passport.new(
      :publish => true,
      :primary => false
    )

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @passport }
    end
  end

  # GET /passports/1/edit
  def edit
    @items = items_list
    @repositories = repositories_list
    @passport = Passport.find(params[:id])
  end

  # POST /passports
  # POST /passports.xml
  def create
    @passport = Passport.new(params[:passport])
    @items = items_list
    @repositories = repositories_list
    respond_to do |format|
      if @passport.save
        format.html { redirect_to(admin_passport_path(@passport), :notice => 'Passport was successfully created.') }
        format.js { render :template => 'admin/items/add_passport_to_item' }
        format.xml  { render :xml => @passport, :status => :created, :location => @passport }
      else
        format.html { render :action => "new" }
        format.js { render :template => 'admin/items/add_passport_to_item' }
        format.xml  { render :xml => @passport.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /passports/1
  # PUT /passports/1.xml
  def update
    @passport = Passport.find(params[:id])
    @repositories = repositories_list
    @items = items_list

    respond_to do |format|
      if @passport.update_attributes(params[:passport])
        format.html { redirect_to(admin_passport_path(@passport), :notice => 'Passport was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @passport.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /passports/1
  # DELETE /passports/1.xml
  def destroy
    # first find the item in case this is a javascript request from the item perspective
    
    @passport = Passport.find(params[:id])
    @item = @passport.item
    @passport.destroy

    respond_to do |format|
      format.html { redirect_to(admin_passports_url) }
      format.js { render :template => 'items/remove_passport_from_item' }
      format.xml  { head :ok }
    end
  end

  private

  def items_list
    Item.all(:select => 'items.id, item_translations.title', :order => 'item_translations.title').map { |i| [i.to_label, i.id]}
  end

  def repositories_list
    Repository.all(:select => 'repositories.id, repository_translations.name', :order => 'repository_translations.name').map { |r| [r.to_label, r.id]}
  end
end
