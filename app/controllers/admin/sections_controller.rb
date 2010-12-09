class Admin::SectionsController < Admin::AdminController
  # GET /sections
  # GET /sections.xml
  def index
    @sections = Section.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @sections }
    end
  end

  # GET /sections/1
  # GET /sections/1.xml
  def show
    @section = Section.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @section }
    end
  end

  # GET /sections/new
  # GET /sections/new.xml
  def new
    @section = Section.new

    @items = Item.select_list
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @section }
    end
  end

  # GET /sections/1/edit
  def edit
    @section = Section.find(params[:id])
    
    @items = Item.select_list
  end

  # POST /sections
  # POST /sections.xml
  def create
    @section = Section.new(params[:section])
    @item = @section.item
    @items = Item.select_list
    respond_to do |format|
      if @section.save
        format.html { redirect_to(admin_section_path(@section), :notice => 'Section was successfully created.') }
        format.xml  { render :xml => @section, :status => :created, :section => @section }
        format.js { render :template => 'admin/items/add_section_to_item'}
      else
        format.html { render :action => "new" }
        format.js { render :template => 'admin/items/add_section_to_item' }
        format.xml  { render :xml => @section.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /sections/1
  # PUT /sections/1.xml
  def update
    @section = Section.find(params[:id])

    @items = Item.select_list
    respond_to do |format|
      if @section.update_attributes(params[:section])
        format.html { redirect_to(admin_section_path(@section), :notice => 'Section was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @section.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /sections/1
  # DELETE /sections/1.xml
  def destroy
    @section = Section.find(params[:id])
    @item = @section.item
    @section.destroy
    @section = nil

    respond_to do |format|
      format.html { redirect_to(admin_sections_url) }
      format.js { render :template => 'admin/items/remove_section_from_item' }
      format.xml  { head :ok }
    end
  end
end
