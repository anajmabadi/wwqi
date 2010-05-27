class ClassificationsController < ApplicationController
  # GET /classifications
  # GET /classifications.xml
  include ActionView::Helpers::TextHelper
  
  def index
    # paginate the items
    @page = params[:page] || 1
    @per_page = params[:per_page] || Classification.per_page || 10
    @classifications = Classification.paginate(:all,  :include => [:subject, :item], :order => 'subject_id, items.id', :per_page => @per_page, :page => @page)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @classifications }
    end
  end

  # GET /classifications/1
  # GET /classifications/1.xml
  def show
    @classification = Classification.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @classification }
    end
  end

  # GET /classifications/new
  # GET /classifications/new.xml
  def new
    @classification = Classification.new
    @items = get_menu_items
    @subjects = get_menu_subjects
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @classification }
    end
  end

  # GET /classifications/1/edit
  def edit
    @classification = Classification.find(params[:id])
    @items = get_menu_items
    @subjects = get_menu_subjects
  end

  # POST /classifications
  # POST /classifications.xml
  def create
    @classification = Classification.new(params[:classification])
    @items = get_menu_items
    @subjects = get_menu_subjects
    respond_to do |format|
      if @classification.save
        format.html { redirect_to(@classification, :notice => 'Classification was successfully created.') }
        format.xml  { render :xml => @classification, :status => :created, :location => @classification }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @classification.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /classifications/1
  # PUT /classifications/1.xml
  def update
    @classification = Classification.find(params[:id])
    @items = get_menu_items
    @subjects = get_menu_subjects
    respond_to do |format|
      if @classification.update_attributes(params[:classification])
        format.html { redirect_to(@classification, :notice => 'Classification was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @classification.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /classifications/1
  # DELETE /classifications/1.xml
  def destroy
    @classification = Classification.find(params[:id])
    @classification.destroy

    respond_to do |format|
      format.html { redirect_to(classifications_url) }
      format.xml  { head :ok }
    end
  end

  private

  def get_menu_items
    return Item.find(:all, :order => 'items.id').map do |i|
      [truncate(i.title)+' ['+i.id.to_s + ']', i.id]
    end
  end

  def get_menu_subjects
     return Subject.find(:all, :include => :translations, :order => 'subject_translations.name').map do |i|
      [truncate(i.name)+' ['+i.id.to_s + ']',i.id]
    end
  end
end
