class Admin::ClassificationsController < Admin::AdminController
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
    @items = Item.select_list
    @subjects = Subject.select_list
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @classification }
    end
  end

  # GET /classifications/1/edit
  def edit
    @classification = Classification.find(params[:id])
    @items = Item.select_list
    @subjects = Subject.select_list
  end

  # POST /classifications
  # POST /classifications.xml
  def create
    @classification = Classification.new(params[:classification])
    @items = Item.select_list
    @subjects = Subject.select_list
    @item = @classification.item
    respond_to do |format|
      if @classification.save
        @max_position = Classification.maximum(:position, :conditions => ['item_id = ?', @item.id] ) || 0
        @new_classification = Classification.new(
          :item_id => params[:id],
          :publish => true,
          :position => @max_position + 1,
          :item_id => @item.id
        )
        format.html { redirect_to(admin_classification_path(@classification), :notice => 'Classification was successfully created.') }
        format.xml  { render :xml => @classification, :status => :created, :location => @classification }
        format.js { render :template => 'admin/items/add_classification_to_item' }
      else
        @new_classification = @classification
        format.html { render :action => "new" }
        format.xml  { render :xml => @classification.errors, :status => :unprocessable_entity }
        format.js { render :template => 'admin/items/add_classification_to_item' }
      end
    end
  end

  # PUT /classifications/1
  # PUT /classifications/1.xml
  def update
    @classification = Classification.find(params[:id])
    @items = Item.select_list
    @subjects = Subject.select_list
    respond_to do |format|
      if @classification.update_attributes(params[:classification])
        format.html { redirect_to(admin_classification_path(@classification), :notice => 'Classification was successfully updated.') }
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
    @item = @classification.item
    @classification.destroy
    @classification = nil

    respond_to do |format|
      format.html { redirect_to(admin_classifications_url) }
      format.js { render :template => 'admin/items/remove_classification_from_item' }
      format.xml  { head :ok }
    end
  end

end
