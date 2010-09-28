class AppellationsController < Admin::AdminController
  # GET /admin/appellations
  # GET /admin/appellations.xml
  def index
    @admin_appellations = Appellation.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @admin_appellations }
    end
  end

  # GET /admin/appellations/1
  # GET /admin/appellations/1.xml
  def show
    @admin_appellation = Appellation.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @admin_appellation }
    end
  end

  # GET /admin/appellations/new
  # GET /admin/appellations/new.xml
  def new
    @admin_appellation = Appellation.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @admin_appellation }
    end
  end

  # GET /admin/appellations/1/edit
  def edit
    @admin_appellation = Appellation.find(params[:id])
  end

  # POST /admin/appellations
  # POST /admin/appellations.xml
  def create
    @admin_appellation = Appellation.new(params[:admin_appellation])

    respond_to do |format|
      if @admin_appellation.save
        format.html { redirect_to(@admin_appellation, :notice => 'Appellation was successfully created.') }
        format.xml  { render :xml => @admin_appellation, :status => :created, :location => @admin_appellation }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @admin_appellation.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /admin/appellations/1
  # PUT /admin/appellations/1.xml
  def update
    @admin_appellation = Appellation.find(params[:id])

    respond_to do |format|
      if @admin_appellation.update_attributes(params[:admin_appellation])
        format.html { redirect_to(@admin_appellation, :notice => 'Appellation was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @admin_appellation.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/appellations/1
  # DELETE /admin/appellations/1.xml
  def destroy
    @admin_appellation = Appellation.find(params[:id])
    @admin_appellation.destroy

    respond_to do |format|
      format.html { redirect_to(admin_appellations_url) }
      format.xml  { head :ok }
    end
  end
end
