class Admin::PlotsController < Admin::AdminController
  # GET /plots
  # GET /plots.xml
  def index
    @plots = Plot.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @plots }
    end
  end

  # GET /plots/1
  # GET /plots/1.xml
  def show
    @plot = Plot.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @plot }
    end
  end

  # GET /plots/new
  # GET /plots/new.xml
  def new
    @plot = Plot.new(
    :publish => true
    )
    @items = Item.select_list
    @places = Place.select_list
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @plot }
    end
  end

  # GET /plots/1/edit
  def edit
    @items = Item.select_list
    @places = Place.select_list
    @plot = Plot.find(params[:id])
  end

  # POST /plots
  # POST /plots.xml
  def create
    @plot = Plot.new(params[:plot])
    @items = Item.select_list
    @places = Place.select_list
    @item = @plot.item
    respond_to do |format|
      if @plot.save
        @max_position = Plot.maximum(:position, :conditions => ['item_id = ?', @item.id] ) || 0
        @new_plot = Plot.new(
          :publish => true,
          :position => @max_position + 1,
          :item_id => @item.id
        )
        format.html { redirect_to(admin_plot_path(@plot), :notice => 'Plot was successfully created.') }
        format.js { render :template => 'admin/items/add_plot_to_item' }
        format.xml  { render :xml => @plot, :status => :created, :location => @plot }
      else
        @new_plot = @plot
        format.html { render :action => "new" }
        format.js { render :template => 'admin/items/add_plot_to_item' }
        format.xml  { render :xml => @plot.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /plots/1
  # PUT /plots/1.xml
  def update
    @plot = Plot.find(params[:id])
    @items = Item.select_list
    @places = Place.select_list
    respond_to do |format|
      if @plot.update_attributes(params[:plot])
        format.html { redirect_to(admin_plot_path(@plot), :notice => 'Plot was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @plot.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /plots/1
  # DELETE /plots/1.xml
  def destroy
    @plot = Plot.find(params[:id])
    @item = @plot.item
    @plot.destroy
    @plot = nil
    respond_to do |format|
      format.html { redirect_to(admin_plots_url) }
      format.js { render :template => 'admin/items/remove_plot_from_item' }
      format.xml  { head :ok }
    end
  end
end
