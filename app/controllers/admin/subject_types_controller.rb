class Admin::SubjectTypesController < Admin::AdminController
  # GET /subject_types
  # GET /subject_types.xml
  def index
    @subject_types = SubjectType.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @subject_types }
    end
  end

  # GET /subject_types/1
  # GET /subject_types/1.xml
  def show
    @subject_type = SubjectType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @subject_type }
    end
  end

  # GET /subject_types/new
  # GET /subject_types/new.xml
  def new
    @subject_type = SubjectType.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @subject_type }
    end
  end

  # GET /subject_types/1/edit
  def edit
    @subject_type = SubjectType.find(params[:id])
  end

  # POST /subject_types
  # POST /subject_types.xml
  def create
    @subject_type = SubjectType.new(params[:subject_type])

    respond_to do |format|
      if @subject_type.save
        format.html { redirect_to(admin_subject_type_path(@subject_type), :notice => 'Subject type was successfully created.') }
        format.xml  { render :xml => @subject_type, :status => :created, :location => @subject_type }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @subject_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /subject_types/1
  # PUT /subject_types/1.xml
  def update
    @subject_type = SubjectType.find(params[:id])

    respond_to do |format|
      if @subject_type.update_attributes(params[:subject_type])
        format.html { redirect_to(admin_subject_type_path(@subject_type), :notice => 'Subject type was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @subject_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /subject_types/1
  # DELETE /subject_types/1.xml
  def destroy
    @subject_type = SubjectType.find(params[:id])
    @subject_type.destroy

    respond_to do |format|
      format.html { redirect_to(admin_subject_types_path) }
      format.xml  { head :ok }
    end
  end
end
