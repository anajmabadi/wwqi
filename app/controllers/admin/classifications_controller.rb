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
    @subjects = Subject.concept_list
    @genres = Subject.genre_list
  end

  # POST /classifications
  # POST /classifications.xml
  def create
    @classification = Classification.new(params[:classification])
    @items = Item.select_list
    @subjects = Subject.concept_list
    @genres = Subject.genre_list
    @item = @classification.item
    @add_concept = params[:classification][:add_concept] == 'true'

    # figure out which template to show
    if @classification.subject.subject_type_id == 8
      @js_template = 'admin/items/add_genre_to_item'
    else
      @js_template =  'admin/items/add_classification_to_item'
    end

    respond_to do |format|
      if @classification.save
        @max_position = Classification.maximum(:position, :conditions => ['item_id = ?', @item.id] ) || 0
        @new_classification = Classification.new(
        :item_id => @item.id,
        :publish => true,
        :position => @max_position + 1
        )
        format.html { redirect_to(admin_classification_path(@classification), :notice => 'Classification was successfully created.') }
        format.xml  { render :xml => @classification, :status => :created, :location => @classification }
        format.js { render :template => @js_template }
      else
        @new_classification = @classification
        format.html { render :action => "new" }
        format.xml  { render :xml => @classification.errors, :status => :unprocessable_entity }
        format.js { render :template => @js_template }
      end
    end
  end

  # PUT /classifications/1
  # PUT /classifications/1.xml
  def update
    @classification = Classification.find(params[:id])
    @items = Item.select_list
    @subjects = Subject.concept_list
    @genres = Subject.genre_list
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
    
    # figure out which template to show
    if @classification.subject.subject_type_id == 8
      @js_template = 'admin/items/remove_genre_from_item'
    else
      @js_template =  'admin/items/remove_classification_from_item'
    end
    
    @classification.destroy
    @classification = nil
    
    respond_to do |format|
      format.html { redirect_to(admin_classifications_url) }

      format.js { render :template => @js_template }
      format.xml  { head :ok }
    end
  end

end
