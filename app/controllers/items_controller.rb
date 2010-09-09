class ItemsController < ApplicationController

  before_filter :admin_required, :except => [:index, :show]
  before_filter :find_item, :only => [:show, :edit, :update, :destroy]

  # GET /items
  # GET /items.xml
  def index
    @page = params[:page] || 1
    @per_page = params[:per_page] || Item.per_page || 50

    #grab the sort mode
    @sort_mode = ['alpha_asc','alpha_dsc','date_asc','date_dsc'].include?(params[:sort_mode]) ? params[:sort_mode] : session[:sort_mode] || 'alpha_asc'
    @order = build_order_query(@sort_mode)

    # look for filters
    @keyword_filter = params[:keyword_filter]

    @query_hash = { :conditions => ['items.publish=:publish','item_translations.locale=:locale'], :parameters => {:publish => 1, :locale => I18n.locale.to_s } }
#    @query_hash = build_collection_query(@collection_filter, @query_hash) unless @collection_filter.nil? || @collection_filter == 'all'
#    @query_hash = build_period_query(@period_filter, @query_hash) unless @period_filter.nil? || @period_filter == 'all'
#    @query_hash = build_person_query(@person_filter, @query_hash) unless @person_filter.nil? || @person_filter == 'all'
#    @query_hash = build_subject_query(@subject_filter, @query_hash) unless @subject_filter.nil? || @subject_filter == 'all'
#    @query_hash = build_place_query(@place_filter, @query_hash) unless @place_filter.nil? || @place_filter == 'all'
#    @query_hash = build_subject_type_query(@subject_type_filter, @query_hash) unless @subject_type_filter.nil? || @subject_type_filter == 'all'
    @query_hash = build_keyword_query(@keyword_filter, @query_hash) unless @keyword_filter.blank? || @keyword_filter == I18n.translate(:search_prompt)

    # assemble the query from the two sql injection safe parts
    @query_conditions = ''
    @query_hash[:conditions].each do |condition|
      @query_conditions += (@query_conditions.blank? ? '': ' AND ') + condition
    end

    @query = [@query_conditions, @query_hash[:parameters]]

    @items = Item.paginate :conditions => @query, :per_page => @per_page, :page => @page, :order => @order
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @items }
    end
  end

  # GET /items/1
  # GET /items/1.xml
  def show
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @item }
    end
  end

  # GET /items/new
  # GET /items/new.xml
  def new
    @item = Item.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @item }
    end
  end

  # GET /items/1/edit
  def edit
  end

  # POST /items
  # POST /items.xml
  def create
    @item = Item.new(params[:item])
    @item.subjects = Subject.find(params[:subject_ids]) if params[:subject_ids]
    respond_to do |format|
      if @item.save
        format.html { redirect_to(@item, :notice => 'Item was successfully created.') }
        format.xml  { render :xml => @item, :status => :created, :location => @item }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /items/1
  # PUT /items/1.xml
  def update
    @item.subjects = Subject.find(params[:subject_ids]) if params[:subject_ids]
    respond_to do |format|
      if @item.update_attributes(params[:item])
        format.html { redirect_to(@item, :notice => 'Item was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.xml
  def destroy
    @item.destroy

    respond_to do |format|
      format.html { redirect_to(items_url, :notice => 'Item was deleted.') }
      format.xml  { head :ok }
    end
  end

  # remote functions for showing and hiding the add passport form
  def show_add_passport_to_item
    # retrieve @repositories for instant additions
    @item = Item.find(params[:id])
    @repositories = repositories_list
    @max_position = Passport.maximum(:position, :conditions => ['item_id = ?', params[:id]] ) || 0
    @passport = Passport.new(
                              :item_id => params[:id],
                              :publish => true,
                              :primary => false,
                              :position => @max_position + 1
    )
    respond_to do |format|
      format.html { render :action => "show", :id => @item }
      format.js
    end
  end

  def hide_add_passport_to_item
    @passport = nil
    @item = Item.find(params[:id])
    respond_to do |format|
      format.html { render :action => "show", :id => @item }
      format.js
    end
  end
  
  private
  
  def find_item
    begin
      @item = Item.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      #TODO: Translate this field
      flash[:error] = "The item you were looking for could not be found."
      redirect_to items_path
    end
  end

  def repositories_list
    Repository.all(:select => 'repositories.id, repository_translations.name', :order => 'repository_translations.name').map { |r| [r.to_label, r.id]}
  end

  def build_keyword_query(filter_value, query_hash)
    additional_query = ''
    filter_value = filter_value.lstrip
    filter_value = filter_value.length > 256 ? filter_value[0..255] : filter_value
    filter_value = filter_value.upcase #locale insensitive
    filter_value = "%#{filter_value}%"
    # ucase if it English
    if I18n.locale == :en
      additional_query += "CONCAT_WS('|', UPPER(item_translations.title), UPPER(item_translations.description), UPPER(accession_num), CONCAT('ID',items.id)) LIKE :keyword" unless filter_value.blank?
    else
      additional_query += "CONCAT_WS('|',item_translations.title, item_translations.description, accession_num, items.id) LIKE :keyword" unless filter_value.blank?
    end

    query_hash[:conditions] << additional_query
    query_hash[:parameters][:keyword] = filter_value
    return query_hash
  end


  def build_order_query(sort_mode)
    additional_sort = ''
    additional_sort += case sort_mode
    when 'alpha_asc' then 'item_translations.locale, item_translations.title'
    when 'alpha_dsc' then 'item_translations.locale, item_translations.title DESC'
    when 'date asc' then 'items.sort_date'
    when 'date dsc' then 'items.sort_date DESC'
    else 'item_translations.locale, item_translations.title'
    end
    return additional_sort
  end
end
