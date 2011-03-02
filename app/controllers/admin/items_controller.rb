class Admin::ItemsController < Admin::AdminController

  require 'csv'

  before_filter :find_item, :only => [:show, :edit, :update, :destroy]

  def util_update_sort_date
    @items = Item.all
    @changed_items = []
    @items.each do |item|
      if item.sort_year.blank? || item.sort_month.blank? || item.sort_day.blank?
        unless item.year.blank?
        new_date = item.gregorian_date
        item.sort_year = new_date[2] unless item.sort_year == new_date[2]
        item.sort_month = new_date[0] unless item.sort_month == new_date[0]
        item.sort_day = new_date[1] unless item.sort_day == new_date[1]
        item.save
        @changed_items << item.id.to_s
        end
      end
    end

    flash[:notice] = "changed these item ids: " + @changed_items.to_s
    redirect_to :action => 'index'

  end

  # GET /items
  # GET /items.xml
  def index

    # gather data for pull down lists
    @collections = Collection.select_list
    @periods = Period.select_list
    @genres = Subject.genres.where(['subject_translations.locale=?', :en.to_s]).order('subject_translations.name')
    
    @page = params[:page] || 1
    @per_page = params[:per_page] || Item.per_page || 100

    @sort_field = params[:c] ||= 'items.id'
    @order = sort_order('items.id')  unless @sort_field == 'title_en' || @sort_field == 'title_fa'

    # look for filters
    @keyword_filter = params[:keyword_filter] unless params[:keyword_filter] == I18n.translate(:search_prompt)
    @collection_filter = params[:collection_filter]
    @period_filter = params[:period_filter]
    @genre_filter = params[:genre_filter]

    # unless @keyword_filter.nil? && @collection_filter.nil? && period_filer.nil? && subject_type_filter.nil?

    @query_hash = { :conditions => [], :parameters => { } }
    @query_hash = build_collection_query(@collection_filter, @query_hash) unless @collection_filter.nil? || @collection_filter == 'all'
    @query_hash = build_period_query(@period_filter, @query_hash) unless @period_filter.nil? || @period_filter == 'all'
    #    @query_hash = build_person_query(@person_filter, @query_hash) unless @person_filter.nil? || @person_filter == 'all'
    #    @query_hash = build_subject_query(@subject_filter, @query_hash) unless @subject_filter.nil? || @subject_filter == 'all'
    #    @query_hash = build_place_query(@place_filter, @query_hash) unless @place_filter.nil? || @place_filter == 'all'
    @query_hash = build_genre_query(@genre_filter, @query_hash) unless @genre_filter.nil? || @genre_filter == 'all'
    @query_hash = build_keyword_query(@keyword_filter, @query_hash) unless @keyword_filter.blank? || @keyword_filter == I18n.translate(:search_prompt)

    # assemble the query from the two sql injection safe parts
    @query_conditions = ''
    @query_hash[:conditions].each do |condition|
      @query_conditions += (@query_conditions.blank? ? '': ' AND ') + condition
    end

    @query = [@query_conditions, @query_hash[:parameters]]

    @items = Item.where(@query).order(@order)

    @items = sort_bilingual(@items, params[:c], params[:d]) if ["title_en", "title_fa"].include?params[:c]

    #cache the current search set in a session variable
    session[:_qajar_session][:current_items] = @items.map { |i| i.id }
    session[:_qajar_session][:items_sort_field] = params[:c]
    session[:_qajar_session][:items_direction] = params[:d]
    session[:_qajar_session][:items_order] = @order

    @items_full_set = @items
    @items = @items.paginate :per_page => @per_page, :page => @page, :order => @order

    #cache the current search set in a session variable
    session[:_qajar_session][:admin_items_index_url] = request.fullpath

    respond_to do |format|
      format.html # index.html.erb
      format.csv do
        csv_string = make_custom_csv(@items_full_set)
        # send it to the browsah
        send_data csv_string,
                :type => 'text/csv; charset=utf-8; header=present',
                :disposition => "attachment; filename=items.csv"
      end
      format.xml  { render :xml => @items_full_set }
    end
  end

  def export
    begin
      @items = Item.find(session[:_qajar_session][:current_items])
      @items = Item.all if @items.empty?
    rescue => error
      flash[:error] = "There was a problem finding the current item set: " + error.message
    @error = true
    end

    respond_to do |format|
      format.html { redirect_to admin_items_path, :error => flash[:error] }
      format.csv do
        csv_string = make_custom_csv(@items)
        # send it to the browsah
        send_data csv_string,
                :type => 'text/csv; charset=utf-8; header=present',
                :disposition => "attachment; filename=items.csv"
      end
      format.xml  { render :xml => @items }
    end

  end

  # GET /items/1
  # GET /items/1.xml
  def show
    @persian_focus = !params[:persian_focus].blank? && params[:persian_focus] == 'true' ? true : false
    @return_url = session[:_qajar_session][:admin_items_index_url]
    begin
      @items = load_items(@item)
    rescue StandardError => error
      flash[:error] = error.message ||= 'Your items set was invalid. Reload the items page.'
    @error = true
    end

    respond_to do |format|
      unless @error
        format.html
        format.xml  { render :xml => @item }
      else
        format.html { redirect_to(admin_items_url, :error => flash[:error]) }
      end
    end

  end

  # GET /items/new
  # GET /items/new.xml
  def new
    @item = Item.new
    
    @months = Month.where(['publish=?', true]).order('position, calendar_type_id')
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @item }
    end
  end

  # GET /items/1/edit
  def edit
    
    @months = Month.where(['publish=?', true]).order('position, calendar_type_id')
  end

  # POST /items
  # POST /items.xml
  def create
    @item = Item.new(params[:item])
    @item.subjects = Subject.find(params[:subject_ids]) if params[:subject_ids]
    @items = load_items(@item)
    
    @months = Month.where(['publish=?', true]).order('position, calendar_type_id')
    respond_to do |format|
      if @item.save
        format.html { redirect_to(admin_item_url(@item), :notice => 'Item was successfully created.') }
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
    @items = load_items(@item)
    
    @months = Month.where(['publish=?', true]).order('position, calendar_type_id')
    begin

    # manually check for a lock version
      if @item.lock_version != params[:item][:lock_version].to_i
        raise ActiveRecord::StaleObjectError
      else
        saved = @item.update_attributes(params[:item])
      stale = false
      end

    rescue ActiveRecord::StaleObjectError
    stale = true
    end
    respond_to do |format|
      if saved
        format.html { redirect_to(admin_item_url(@item), :notice => 'Item was successfully updated.') }
        format.xml  { head :ok }
      elsif stale
        # write out the failed parameters
        begin

        # construct a full path to the new file
          filename = 'stale_item_record_' + Time.now.strftime("%m%d%Y%H%M%S") + '.xml'
          local_filename = Rails.root.join('public',filename)

          # make a url the user can use to retrieve this file
          public_url = 'http://' + request.host + '/' + filename

          # convert the new item that cannot be saved to XML
          doc = params[:item].to_xml

          # save it out to that file.
          File.open(local_filename.to_s, 'w') {|f| f.write(doc) }

        rescue StandardError => error
          flash[:error] = "Item was edited and saved by someone else while you were working on it, but we were unable to save your work: " + error
        else
          flash[:error] = "Item was edited and saved by someone else while you were working on it, but we were able to save your work in this XML file: " + public_url
        end
        format.html { redirect_to(admin_item_url(@item), :error => 'Item was edited by someone else first -- please save your work and reload the record.') }
        format.xml  { render :xml => @item.errors, :status => :unprocessable_entity }
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
      format.html { redirect_to(admin_items_url, :notice => 'Item was deleted.') }
      format.xml  { head :ok }
    end
  end

  # remote functions for showing and hiding the add appearance form
  def show_add_appearance_to_item
    # retrieve @appearances for instant additions
    @persian_focus = !params[:persian_focus].blank? && params[:persian_focus] == 'true' ? true : false
    @item = Item.find(params[:id])
    @people = @persian_focus ? Person.select_list_fa : Person.select_list
    #@people_fa = Person.select_list_fa
    @max_position = Appearance.maximum(:position, :conditions => ['item_id = ?', params[:id]] ) || 0
    @appearance = Appearance.new(
    :item_id => params[:id],
    :publish => true,
    :position => @max_position + 1
    )
    respond_to do |format|
      format.html { render :action => "show", :id => @item }
      format.js
    end
  end

  def hide_add_appearance_to_item
    @appearance = nil
    @item = Item.find(params[:id])
    respond_to do |format|
      format.html { render :action => "show", :id => @item }
      format.js
    end
  end
  
  # remote functions for showing and hiding the add alternate title form
  def show_add_alternate_title_to_item
    # retrieve @alternate_titles for instant additions
    @item = Item.find(params[:id])
    @alternate_title = AlternateTitle.new(
    :item_id => params[:id],
    :publish => true
    )
    respond_to do |format|
      format.html { render :action => "show", :id => @item }
      format.js
    end
  end

  def hide_add_alternate_title_to_item
    @alternate_title = nil
    @item = Item.find(params[:id])
    respond_to do |format|
      format.html { render :action => "show", :id => @item }
      format.js
    end
  end

  # remote functions for showing and hiding the add sections form
  def show_add_section_to_item
    @item = Item.find(params[:id])
    @section = Section.new(
    :item_id => params[:id],
    :publish => true
    )
    respond_to do |format|
      format.html { render :action => "show", :id => @item }
      format.js
    end
  end

  def hide_add_section_to_item
    @section = nil
    @item = Item.find(params[:id])
    respond_to do |format|
      format.html { render :action => "show", :id => @item }
      format.js
    end
  end

  # remote functions for showing and hiding the add plot form
  def show_add_plot_to_item
    # retrieve @repositories for instant additions
    @item = Item.find(params[:id])
    @places = Place.select_list
    @max_position = Plot.maximum(:position, :conditions => ['item_id = ?', params[:id]] ) || 0
    @plot = Plot.new(
    :item_id => params[:id],
    :publish => true,
    :position => @max_position + 1
    )
    respond_to do |format|
      format.html { render :action => "show", :id => @item }
      format.js
    end
  end

  def hide_add_plot_to_item
    @plot = nil
    @item = Item.find(params[:id])
    respond_to do |format|
      format.html { render :action => "show", :id => @item }
      format.js
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

  # remote functions for showing and hiding the add passport form
  def show_add_classification_to_item
    # retrieve @repositories for instant additions
    @item = Item.find(params[:id])
    @subjects = Subject.concept_list
    @max_position = Classification.maximum(:position, :conditions => ['item_id = ?', params[:id]] ) || 0
    @classification = Classification.new(
    :item_id => params[:id],
    :publish => true,
    :position => @max_position + 1
    )
    respond_to do |format|
      format.html { render :action => "show", :id => @item }
      format.js
    end
  end

  def hide_add_classification_to_item
    @classification = nil
    @item = Item.find(params[:id])
    respond_to do |format|
      format.html { render :action => "show", :id => @item }
      format.js
    end
  end

  # remote functions for showing and hiding the add passport form
  def show_add_genre_to_item
    # retrieve @repositories for instant additions
    @item = Item.find(params[:id])
    @genres = Subject.genre_list
    @max_position = Classification.maximum(:position, :conditions => ['item_id = ?', params[:id]] ) || 0
    @classification = Classification.new(
    :item_id => params[:id],
    :publish => true,
    :position => @max_position + 1
    )
    respond_to do |format|
      format.html { render :action => "show", :id => @item }
      format.js
    end
  end

  def hide_add_genre_to_item
    @classification = nil
    @item = Item.find(params[:id])
    respond_to do |format|
      format.html { render :action => "show", :id => @item }
      format.js
    end
  end

  # remote functions for showing and hiding the add comp form
  def show_add_comp_to_item
    # retrieve items for instant additions
    @item = Item.find(params[:id])
    @items = Item.select_list
    @max_position = Comp.maximum(:position, :conditions => ['item_id = ?', params[:id]] ) || 0
    @comp = Comp.new(
    :item_id => params[:id],
    :publish => true,
    :position => @max_position + 1
    )
    respond_to do |format|
      format.html { render :action => "show", :id => @item }
      format.js
    end
  end

  def hide_add_comp_to_item
    @comp = nil
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
      redirect_to admin_items_url
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

  def build_subject_type_query(filter_value, query_hash)
    logger.info("build_subject_type_query")
    additional_query = ''
    begin
      @subject_type = SubjectType.find_by_id(filter_value.to_i)
      @subjects = @subject_type.subjects
      @ids = []

      @subjects.each do |subject|
        @ids = @ids.concat(subject.items.map { |p| p.id })
      end

      @ids = @ids.sort.uniq

      unless @ids.empty?
        additional_query += "items.id IN (#{@ids.join(",")})"
      else
      # if the subject type has no items, we should kill search
        flash[:error] = "No items found. Showing all."
      end
    rescue StandardError => error
      flash[:error] = "A problem was encountered searching for subject type #{filter_value.to_s}: #{error}."
    else
      flash[:error] = nil
    ensure
    query_hash[:conditions] << additional_query unless additional_query.blank?
    return query_hash
    end
  end

  def build_period_query(filter_value, query_hash)
    additional_query = ''
    begin
      @period = Period.find_by_id(filter_value.to_i)
      additional_query += "(sort_year BETWEEN '#{@period.start_at.strftime("%Y")}' AND '#{@period.end_at.strftime("%Y")}')"
    rescue StandardError => error
      flash[:error] = "A problem was encountered searching for period id #{filter_value}: #{error}."
    else
      flash[:error] = nil
    ensure
    query_hash[:conditions] << additional_query unless additional_query.blank?
    return query_hash
    end
  end

  def build_collection_query(filter_value, query_hash)
    additional_query = ''
    begin
      @collection = Collection.find_by_id(filter_value.to_i)
      additional_query += 'collection_id = ' + @collection.id.to_s
    rescue StandardError => error
      flash[:error] = "A problem was encountered searching for collection id #{filter_value}: #{error}."
    else
      flash[:error] = nil
    ensure
    query_hash[:conditions] << additional_query unless additional_query.blank?
    return query_hash
    end
  end

  def build_genre_query(filter_value, query_hash)
    additional_query = ''

    if filter_value.kind_of?(Array)
      ids_to_find = filter_value.map { |id| id.to_i }.sort
      if ids_to_find.length == 1
      @genre_label = Subject.find(ids_to_find[0].to_i).name
      else
      @genre_label = I18n.translate(:multiple)
      end
    else
      ids_to_find = [filter_value.to_i]
    end

    begin
      selected_subjects = Subject.find(ids_to_find)
      item_ids = []
      selected_subjects.each do |subject|
        item_ids += subject.items.map { |p| p.id }
      end

      unless item_ids.empty?
        additional_query += "items.id IN (#{item_ids.join(",")})"
      else
      # if the person has no items, we should kill search
        flash[:error] = "No items found. Showing all."
      end
    rescue StandardError => error
      flash[:error] = "A problem was encountered searching for subject id #{filter_value}: #{error}."
    ensure
    query_hash[:conditions] << additional_query unless additional_query.blank?
    return query_hash
    end
  end

  def sort_bilingual(items, bilingual_field, direction)
    begin
      items = case bilingual_field
        when 'title_en' then items.sort_by(&:title_en)
        when 'title_fa' then items.sort_by(&:title_fa)
      else items
      end
      items.reverse! if direction == 'down'
    rescue => error
      flash[:error] = "A problem occured sorting by English or Farsi titles: " + error.message
    end
    return items
  end

  def load_items(item)
    #check if there is a current results set (i.e. something from the browser)
    order = session[:_qajar_session][:items_order] ||= 'items.id'
    unless session[:_qajar_session][:current_items].nil? || session[:_qajar_session][:current_items].empty? || !session[:_qajar_session][:current_items].include?(item.id)
      items = Item.where(['items.id IN (?)', session[:_qajar_session][:current_items]]).order(order)
    else
    items = Item.order(order).all
    end
    items = sort_bilingual(items, session[:_qajar_session][:items_sort_field], session[:_qajar_session][:items_direction]) if ["title_en", "title_fa"].include?session[:_qajar_session][:items_sort_field]
    return items
  end

end
