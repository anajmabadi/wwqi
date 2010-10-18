class Admin::ClipTypesController < Admin::AdminController
  # GET /clip_types
  # GET /clip_types.xml
  def index
    @clip_types = ClipType.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @clip_types }
    end
  end

  # GET /clip_types/1
  # GET /clip_types/1.xml
  def show
    @clip_type = ClipType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @clip_type }
    end
  end

  # GET /clip_types/new
  # GET /clip_types/new.xml
  def new
    @clip_type = ClipType.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @clip_type }
    end
  end

  # GET /clip_types/1/edit
  def edit
    @clip_type = ClipType.find(params[:id])
  end

  # POST /clip_types
  # POST /clip_types.xml
  def create
    @clip_type = ClipType.new(params[:clip_type])

    respond_to do |format|
      if @clip_type.save
        format.html { redirect_to(admin_clip_type_path(@clip_type), :notice => 'Clip type was successfully created.') }
        format.xml  { render :xml => @clip_type, :status => :created, :location => @clip_type }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @clip_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /clip_types/1
  # PUT /clip_types/1.xml
  def update
    @clip_type = ClipType.find(params[:id])

    respond_to do |format|
      if @clip_type.update_attributes(params[:clip_type])
        format.html { redirect_to(admin_clip_type_path(@clip_type), :notice => 'Clip type was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @clip_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /clip_types/1
  # DELETE /clip_types/1.xml
  def destroy
    @clip_type = ClipType.find(params[:id])
    @clip_type.destroy

    respond_to do |format|
      format.html { redirect_to(admin_clip_types_url) }
      format.xml  { head :ok }
    end
  end
end
