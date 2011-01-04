class Admin::AlternateTitlesController < Admin::AdminController
  # GET /alternate_titles
  # GET /alternate_titles.xml
  def index
    @alternate_titles = AlternateTitle.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @alternate_titles }
    end
  end

  # GET /alternate_titles/1
  # GET /alternate_titles/1.xml
  def show
    @alternate_title = AlternateTitle.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @alternate_title }
    end
  end

  # GET /alternate_titles/new
  # GET /alternate_titles/new.xml
  def new
    @alternate_title = AlternateTitle.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @alternate_title }
    end
  end

  # GET /alternate_titles/1/edit
  def edit
    @alternate_title = AlternateTitle.find(params[:id])
  end

  # POST /alternate_titles
  # POST /alternate_titles.xml
  def create
    @alternate_title = AlternateTitle.new(params[:alternate_title])
    @item = Item.find(params[:item_id])
    @js_template =  'admin/items/add_alternate_title_to_item'
    respond_to do |format|
      if @alternate_title.save
        @new_alternate_title = AlternateTitle.new(
        :item_id => params[:item_id],
        :publish => true
        )
        format.html { redirect_to( admin_item_alternate_title_path(@alternate_title), :notice => 'Alternate title was successfully created.') }
        format.xml  { render :xml => @alternate_title, :status => :created, :location => @alternate_title }
        format.js { render :template => @js_template }
      else
        @new_alternate_title = @alternate_title
        format.html { render :action => "new" }
        format.xml  { render :xml => @alternate_title.errors, :status => :unprocessable_entity }
        format.js { render :template => @js_template }
      end
    end
  end

  # PUT /alternate_titles/1
  # PUT /alternate_titles/1.xml
  def update
    @alternate_title = AlternateTitle.find(params[:id])

    respond_to do |format|
      if @alternate_title.update_attributes(params[:alternate_title])
        format.html { redirect_to(admin_item_alternate_title_path(@alternate_title), :notice => 'Alternate title was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @alternate_title.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /alternate_titles/1
  # DELETE /alternate_titles/1.xml
  def destroy
    @alternate_title = AlternateTitle.find(params[:id])
    @item = @alternate_title.item
    @alternate_title.destroy

    respond_to do |format|
      format.html { redirect_to(admin_item_alternate_titles_url) }
      format.xml  { head :ok }
      format.js { render :template => "/admin/items/remove_alternate_title_from_item" }
    end
  end
end
