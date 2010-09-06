class PassportsController < ApplicationController
  # GET /passports
  # GET /passports.xml
  def index
    @passports = Passport.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @passports }
    end
  end

  # GET /passports/1
  # GET /passports/1.xml
  def show
    @passport = Passport.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @passport }
    end
  end

  # GET /passports/new
  # GET /passports/new.xml
  def new
    @passport = Passport.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @passport }
    end
  end

  # GET /passports/1/edit
  def edit
    @passport = Passport.find(params[:id])
  end

  # POST /passports
  # POST /passports.xml
  def create
    @passport = Passport.new(params[:passport])

    respond_to do |format|
      if @passport.save
        format.html { redirect_to(@passport, :notice => 'Passport was successfully created.') }
        format.xml  { render :xml => @passport, :status => :created, :location => @passport }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @passport.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /passports/1
  # PUT /passports/1.xml
  def update
    @passport = Passport.find(params[:id])

    respond_to do |format|
      if @passport.update_attributes(params[:passport])
        format.html { redirect_to(@passport, :notice => 'Passport was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @passport.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /passports/1
  # DELETE /passports/1.xml
  def destroy
    @passport = Passport.find(params[:id])
    @passport.destroy

    respond_to do |format|
      format.html { redirect_to(passports_url) }
      format.xml  { head :ok }
    end
  end
end
