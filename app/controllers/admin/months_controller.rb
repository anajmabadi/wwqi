class MonthsController < Admin::AdminController
  # GET /months
  # GET /months.xml
  def index
    @months = Month.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @months }
    end
  end

  # GET /months/1
  # GET /months/1.xml
  def show
    @month = Month.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @month }
    end
  end

  # GET /months/new
  # GET /months/new.xml
  def new
    @month = Month.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @month }
    end
  end

  # GET /months/1/edit
  def edit
    @month = Month.find(params[:id])
  end

  # POST /months
  # POST /months.xml
  def create
    @month = Month.new(params[:month])

    respond_to do |format|
      if @month.save
        format.html { redirect_to([:admin, @month], :notice => 'Month was successfully created.') }
        format.xml  { render :xml => @month, :status => :created, :location => @month }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @month.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /months/1
  # PUT /months/1.xml
  def update
    @month = Month.find(params[:id])

    respond_to do |format|
      if @month.update_attributes(params[:month])
        format.html { redirect_to([:admin, @month], :notice => 'Month was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @month.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /months/1
  # DELETE /months/1.xml
  def destroy
    @month = Month.find(params[:id])
    @month.destroy

    respond_to do |format|
      format.html { redirect_to(admin_months_url) }
      format.xml  { head :ok }
    end
  end
end
