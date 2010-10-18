class Admin::AppearancesController < Admin::AdminController

  # GET /appearances
  # GET /appearances.xml
  def index
    @appearances = Appearance.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @appearances }
    end
  end

  # GET /appearances/1
  # GET /appearances/1.xml
  def show
    @appearance = Appearance.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @appearance }
    end
  end

  # GET /appearances/new
  # GET /appearances/new.xml
  def new
    @appearance = Appearance.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @appearance }
    end
  end

  # GET /appearances/1/edit
  def edit
    @appearance = Appearance.find(params[:id])
  end

  # POST /appearances
  # POST /appearances.xml
  def create
    @appearance = Appearance.new(params[:appearance])

    respond_to do |format|
      if @appearance.save
        format.html { redirect_to(admin_appearance_path(@appearance), :notice => 'Appearance was successfully created.') }
        format.xml  { render :xml => @appearance, :status => :created, :location => @appearance }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @appearance.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /appearances/1
  # PUT /appearances/1.xml
  def update
    @appearance = Appearance.find(params[:id])

    respond_to do |format|
      if @appearance.update_attributes(params[:appearance])
        format.html { redirect_to(admin_appearance_path(@appearance), :notice => 'Appearance was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @appearance.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /appearances/1
  # DELETE /appearances/1.xml
  def destroy
    @appearance = Appearance.find(params[:id])
    @appearance.destroy

    respond_to do |format|
      format.html { redirect_to(admin_appearances_url) }
      format.xml  { head :ok }
    end
  end
end
