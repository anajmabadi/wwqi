class Admin::PlacesController < Admin::AdminController
  # GET /places
  # GET /places.xml
  def index
    
    # set the default order
    params[:c] = 'name_en' if params[:c].blank?
    @order = sort_order('places.id') unless params[:c] == 'name_en' || params[:c] == 'name_fa'

    # look for filters
    @keyword_filter = params[:keyword_filter] unless params[:keyword_filter] == I18n.translate(:search_prompt)
    
    @query_hash = { :conditions => [], :parameters => {} }
    @query_hash = build_keyword_query(@keyword_filter, @query_hash) unless @keyword_filter.blank? || @keyword_filter == I18n.translate(:search_prompt)
    
    # assemble the query from the two sql injection safe parts
    @query_conditions = ''
    @query_hash[:conditions].each do |condition|
      @query_conditions += (@query_conditions.blank? ? '': ' AND ') + condition
    end

    @query = [@query_conditions, @query_hash[:parameters]]

    @places = Place.where(@query).order(@order)

    @places = sort_bilingual(@places, params[:c], params[:d]) if ["name_en", "name_fa"].include?(params[:c])

    #cache the current search set in a session variable
    session[:admin_places_index_url] = request.fullpath
	session[:current_places] = @places.map { |p| p.id }
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @places }
    end
  end
  
  

  def export
	begin
		unless session[:current_places].nil?
			@places = Place.find(session[:current_places]) 
		else
			@places = Place.all
		end
	rescue => error
		flash[:error] = "There was a problem finding places: " + error.message
		@error = true
	end
	respond_to do |format|
		format.html { redirect_to admin_places_path, :error => flash[:error] }
		format.csv do
			csv_string = make_custom_csv(@places)
			# send it to the browsah
			send_data csv_string,
	        :type => 'text/csv; charset=utf-8; header=present',
	        :disposition => "attachment; filename=places.csv"
		end
		format.xml  { render :xml => @places }
	end
  end

  # GET /places/1
  # GET /places/1.xml
  def show
    @place = Place.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @place }
    end
  end

  # GET /places/new
  # GET /places/new.xml
  def new
    @place = Place.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @place }
    end
  end

  # GET /places/1/edit
  def edit
    @place = Place.find(params[:id])
  end

  # POST /places
  # POST /places.xml
  def create
    @place = Place.new(params[:place])

    respond_to do |format|
      if @place.save
        format.html { redirect_to(admin_place_path(@place), :notice => 'Place was successfully created.') }
        format.xml  { render :xml => @place, :status => :created, :location => @place }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @place.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /places/1
  # PUT /places/1.xml
  def update
    @place = Place.find(params[:id])

    respond_to do |format|
      if @place.update_attributes(params[:place])
        format.html { redirect_to(admin_place_path(@place), :notice => 'Place was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @place.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /places/1
  # DELETE /places/1.xml
  def destroy
    @place = Place.find(params[:id])
    @place.destroy

    respond_to do |format|
      format.html { redirect_to(admin_places_url) }
      format.xml  { head :ok }
    end
  end
  
  private
  
  def build_keyword_query(filter_value, query_hash)
    additional_query = ''
    filter_value = filter_value.lstrip
    filter_value = filter_value.length > 256 ? filter_value[0..255] : filter_value
    filter_value = filter_value.upcase #locale insensitive
    filter_value = "%#{filter_value}%"
    keyword_query = "UPPER(place_translations.name) LIKE :keyword" unless filter_value.blank?
    ids = Place.where([keyword_query, {:keyword => filter_value}]).select('places.id').order('places.id').map { |i| i.id }
    additional_query += "places.id IN (:keyword_ids)"
    query_hash[:conditions] << additional_query
    query_hash[:parameters][:keyword_ids] = ids
    return query_hash
  end

  def sort_bilingual(rows, bilingual_field, direction)
    rows = case bilingual_field
      when 'name_en' then rows.sort_by(&:name_en)
      when 'name_fa' then rows.sort_by(&:name_fa)
    else rows
    end
    rows.reverse! if direction == 'down'
    return rows
  end

end
