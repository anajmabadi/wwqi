class Admin::ErasController < Admin::AdminController
  # GET /eras
  # GET /eras.xml
  def index
    @eras = Era.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @eras }
    end
  end

  # GET /eras/1
  # GET /eras/1.xml
  def show
    @era = Era.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @era }
    end
  end

  # GET /eras/new
  # GET /eras/new.xml
  def new
    @era = Era.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @era }
    end
  end

  # GET /eras/1/edit
  def edit
    @era = Era.find(params[:id])
  end

  # POST /eras
  # POST /eras.xml
  def create
    @era = Era.new(params[:era])

    respond_to do |format|
      if @era.save
        format.html { redirect_to(admin_era_path(@era), :notice => 'Era was successfully created.') }
        format.xml  { render :xml => @era, :status => :created, :location => @era }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @era.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /eras/1
  # PUT /eras/1.xml
  def update
    @era = Era.find(params[:id])

    respond_to do |format|
      if @era.update_attributes(params[:era])
        format.html { redirect_to(admin_era_path(@era), :notice => 'Era was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @era.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /eras/1
  # DELETE /eras/1.xml
  def destroy
    @era = Era.find(params[:id])
    @era.destroy

    respond_to do |format|
      format.html { redirect_to(admin_eras_url) }
      format.xml  { head :ok }
    end
  end
end
