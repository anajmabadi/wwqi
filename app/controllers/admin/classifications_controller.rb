class Admin:: ClassificationsController < Admin::AdminController
  # GET /class Admin::ifications
  # GET /class Admin::ifications.xml
  include ActionView::Helpers::TextHelper
  
  def index
    # paginate the items
    @page = params[:page] || 1
    @per_page = params[:per_page] || Classification.per_page || 10
    @class Admin::ifications = Classification.paginate(:all,  :include => [:subject, :item], :order => 'subject_id, items.id', :per_page => @per_page, :page => @page)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @class Admin::ifications }
    end
  end

  # GET /class Admin::ifications/1
  # GET /class Admin::ifications/1.xml
  def show
    @class Admin::ification = Classification.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @class Admin::ification }
    end
  end

  # GET /class Admin::ifications/new
  # GET /class Admin::ifications/new.xml
  def new
    @class Admin::ification = Classification.new
    @items = get_menu_items
    @subjects = get_menu_subjects
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @class Admin::ification }
    end
  end

  # GET /class Admin::ifications/1/edit
  def edit
    @class Admin::ification = Classification.find(params[:id])
    @items = get_menu_items
    @subjects = get_menu_subjects
  end

  # POST /class Admin::ifications
  # POST /class Admin::ifications.xml
  def create
    @class Admin::ification = Classification.new(params[:class Admin::ification])
    @items = get_menu_items
    @subjects = get_menu_subjects
    respond_to do |format|
      if @class Admin::ification.save
        format.html { redirect_to(@class Admin::ification, :notice => 'Classification was successfully created.') }
        format.xml  { render :xml => @class Admin::ification, :status => :created, :location => @class Admin::ification }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @class Admin::ification.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /class Admin::ifications/1
  # PUT /class Admin::ifications/1.xml
  def update
    @class Admin::ification = Classification.find(params[:id])
    @items = get_menu_items
    @subjects = get_menu_subjects
    respond_to do |format|
      if @class Admin::ification.update_attributes(params[:class Admin::ification])
        format.html { redirect_to(@class Admin::ification, :notice => 'Classification was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @class Admin::ification.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /class Admin::ifications/1
  # DELETE /class Admin::ifications/1.xml
  def destroy
    @class Admin::ification = Classification.find(params[:id])
    @class Admin::ification.destroy

    respond_to do |format|
      format.html { redirect_to(class Admin::ifications_url) }
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
     return Subject.find(:all, :include => :translations, :order => 'subject_translations.locale, subject_translations.name').map do |i|
      [truncate(i.name)+' ['+i.id.to_s + ']',i.id]
    end
  end
end
