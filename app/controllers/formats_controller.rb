class FormatsController < ApplicationController
  # GET /formats
  # GET /formats.xml
  def index
    @formats = Format.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @formats }
    end
  end

  # GET /formats/1
  # GET /formats/1.xml
  def show
    @format = Format.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @format }
    end
  end

  # GET /formats/new
  # GET /formats/new.xml
  def new
    @format = Format.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @format }
    end
  end

  # GET /formats/1/edit
  def edit
    @format = Format.find(params[:id])
  end

  # POST /formats
  # POST /formats.xml
  def create
    @format = Format.new(params[:format])

    respond_to do |format|
      if @format.save
        format.html { redirect_to(@format, :notice => 'Format was successfully created.') }
        format.xml  { render :xml => @format, :status => :created, :location => @format }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @format.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /formats/1
  # PUT /formats/1.xml
  def update
    @format = Format.find(params[:id])

    respond_to do |format|
      if @format.update_attributes(params[:format])
        format.html { redirect_to(@format, :notice => 'Format was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @format.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /formats/1
  # DELETE /formats/1.xml
  def destroy
    @format = Format.find(params[:id])
    @format.destroy

    respond_to do |format|
      format.html { redirect_to(formats_url) }
      format.xml  { head :ok }
    end
  end
end
