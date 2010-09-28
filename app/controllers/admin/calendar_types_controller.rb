class Admin::CalendarTypesController < Admin::AdminController
  # GET /calendar_types
  # GET /calendar_types.xml
  def index
    @calendar_types = CalendarType.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @calendar_types }
    end
  end

  # GET /calendar_types/1
  # GET /calendar_types/1.xml
  def show
    @calendar_type = CalendarType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @calendar_type }
    end
  end

  # GET /calendar_types/new
  # GET /calendar_types/new.xml
  def new
    @calendar_type = CalendarType.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @calendar_type }
    end
  end

  # GET /calendar_types/1/edit
  def edit
    @calendar_type = CalendarType.find(params[:id])
  end

  # POST /calendar_types
  # POST /calendar_types.xml
  def create
    @calendar_type = CalendarType.new(params[:calendar_type])

    respond_to do |format|
      if @calendar_type.save
        format.html { redirect_to(@calendar_type, :notice => 'Calendar type was successfully created.') }
        format.xml  { render :xml => @calendar_type, :status => :created, :location => @calendar_type }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @calendar_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /calendar_types/1
  # PUT /calendar_types/1.xml
  def update
    @calendar_type = CalendarType.find(params[:id])

    respond_to do |format|
      if @calendar_type.update_attributes(params[:calendar_type])
        format.html { redirect_to(@calendar_type, :notice => 'Calendar type was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @calendar_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /calendar_types/1
  # DELETE /calendar_types/1.xml
  def destroy
    @calendar_type = CalendarType.find(params[:id])
    @calendar_type.destroy

    respond_to do |format|
      format.html { redirect_to(calendar_types_url) }
      format.xml  { head :ok }
    end
  end
end
