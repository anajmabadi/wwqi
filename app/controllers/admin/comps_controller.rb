class Admin::CompsController < Admin::AdminController
  # GET /comps
  # GET /comps.xml
  def index
    @comps = Comp.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @comps }
    end
  end

  # GET /comps/1
  # GET /comps/1.xml
  def show
    @comp = Comp.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @comp }
    end
  end

  # GET /comps/new
  # GET /comps/new.xml
  def new
    @comp = Comp.new

    @items = Item.select_list
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @comp }
    end
  end

  # GET /comps/1/edit
  def edit
    @comp = Comp.find(params[:id])
    @items = Item.select_list
  end

  # POST /comps
  # POST /comps.xml
  def create
    @comp = Comp.new(params[:comp])
    @items = Item.select_list
    @item = @comp.item
    respond_to do |format|
      if @comp.save
        @max_position = Comp.maximum(:position, :conditions => ['item_id = ?', @item.id] ) || 0
        @new_comp = Comp.new(
          :item_id => params[:id],
          :publish => true,
          :position => @max_position + 1,
          :item_id => @item.id
        )
        format.html { redirect_to(admin_comp_path(@comp), :notice => 'Comp was successfully created.') }
        format.xml  { render :xml => @comp, :status => :created }
        format.js { render :template => 'admin/items/add_comp_to_item' }
      else
        @new_comp = @comp
        format.html { render :action => "new" }
        format.xml  { render :xml => @comp.errors, :status => :unprocessable_entity }
        format.js { render :template => 'admin/items/add_comp_to_item' }
      end
    end
  end

  # PUT /comps/1
  # PUT /comps/1.xml
  def update
    @comp = Comp.find(params[:id])
    @items = Item.select_list
    respond_to do |format|
      if @comp.update_attributes(params[:comp])
        format.html { redirect_to(admin_comp_path(@comp), :notice => 'Comp was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @comp.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /comps/1
  # DELETE /comps/1.xml
  def destroy
    @comp = Comp.find(params[:id])
    @item = @comp.item
    @comp.destroy
    @comp = nil

    respond_to do |format|
      format.html { redirect_to(admin_comps_url) }
      format.js { render :template => 'admin/items/remove_comp_from_item' }
      format.xml  { head :ok }
    end
  end
end
