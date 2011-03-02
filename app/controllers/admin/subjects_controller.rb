class Admin::SubjectsController < Admin::AdminController
  # GET /subjects
  # GET /subjects.xml
  def index
    # paginate the subjects
    @page = params[:page] || 1
    @per_page = params[:per_page] || Subject.per_page || 100

    @order = sort_order('subjects.id') unless params[:c] == 'name_en' || params[:c] == 'name_fa'

    # look for filters
    @keyword_filter = params[:keyword_filter] unless params[:keyword_filter] == I18n.translate(:search_prompt)
    @subject_type_filter = params[:subject_type_filter]

    @query_hash = { :conditions => [], :parameters => {} }
    @query_hash = build_subject_type_query(@subject_type_filter, @query_hash) unless @subject_type_filter.nil? || @subject_type_filter == 'all'
    @query_hash = build_keyword_query(@keyword_filter, @query_hash) unless @keyword_filter.blank? || @keyword_filter == I18n.translate(:search_prompt)

    # assemble the query from the two sql injection safe parts
    @query_conditions = ''
    @query_hash[:conditions].each do |condition|
      @query_conditions += (@query_conditions.blank? ? '': ' AND ') + condition
    end

    @query = [@query_conditions, @query_hash[:parameters]]

    @subjects = Subject.where(@query).order(@order)

    @subjects = sort_bilingual(@subjects, params[:c], params[:d]) if ["name_en", "name_fa"].include?(params[:c])

    @subject_types = SubjectType.select_list

    #cache the current search set in a session variable
    session[:_qajar_session][:admin_subjects_index_url] = request.fullpath
    #cache the current search set in a session variable
    session[:_qajar_session][:current_subects] = @subjects.map { |i| i.id }
    session[:_qajar_session][:subject_sort_field] = params[:c]
    session[:_qajar_session][:subject_direction] = params[:d]
    session[:_qajar_session][:subject_order] = @order

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @subjects }
    end
  end

  # GET /subjects/1
  # GET /subjects/1.xml
  def show

    begin
      @subject = Subject.find(params[:id])
      @subjects = load_subjects(@subject)

    rescue StandardError => error
      flash[:error] = error.message ||= 'Person with id number ' + params[:id].to_s + ' was not found or your people set was invalid. Reload the people page.'
      @error = true
    end

    respond_to do |format|
      unless @error
        format.html
        format.xml  { render :xml => @item }
      else
        format.html { redirect_to(admin_subjects_url, :error => flash[:error]) }
      end
    end
  end

  # GET /subjects/new
  # GET /subjects/new.xml
  def new
    @subject = Subject.new
    @subject_types = SubjectType.select_list
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @subject }
    end
  end

  # GET /subjects/1/edit
  def edit
    @subject = Subject.find(params[:id])
    @subject_types = SubjectType.select_list
  end

  # POST /subjects
  # POST /subjects.xml
  def create
    @subject = Subject.new(params[:subject])
    @subject_types = SubjectType.select_list
    respond_to do |format|
      if @subject.save
        format.html { redirect_to(admin_subject_path(@subject), :notice => 'Subject was successfully created.') }
        format.xml  { render :xml => @subject, :status => :created, :location => @subject }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @subject.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /subjects/1
  # PUT /subjects/1.xml
  def update
    @subject = Subject.find(params[:id])
    @subject_types = SubjectType.select_list
    respond_to do |format|
      if @subject.update_attributes(params[:subject])
        format.html { redirect_to(admin_subject_path(@subject), :notice => 'Subject was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @subject.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /subjects/1
  # DELETE /subjects/1.xml
  def destroy

    begin
      @subject = Subject.find(params[:id])
      @subject.destroy
    rescue => error
      @failure_message = error.message
    ensure
      respond_to do |format|
        if @failure_message.blank?
          flash[:notice] = 'Subject successfully deleted'
        else
          flash[:error] = @failure_message
        end
        format.html { redirect_to(session[:_qajar_session][:admin_subjects_index_url] ||= admin_subjects_path) }
        format.xml  { head :ok }
      end
    end
  end

  private

  def build_subject_type_query(filter_value, query_hash)
    additional_query = ''
    additional_query += "subjects.subject_type_id = :subject_type_id" unless filter_value.blank?
    query_hash[:conditions] << additional_query
    query_hash[:parameters][:subject_type_id] = filter_value
    return query_hash
  end

  def build_keyword_query(filter_value, query_hash)
    additional_query = ''
    filter_value = filter_value.lstrip
    filter_value = filter_value.length > 256 ? filter_value[0..255] : filter_value
    filter_value = filter_value.upcase #locale insensitive
    filter_value = "%#{filter_value}%"
    keyword_query = "UPPER(subject_translations.name) LIKE :keyword" unless filter_value.blank?
    ids = Subject.where([keyword_query, {:keyword => filter_value}]).select('subjects.id').order('subjects.id').map { |i| i.id }
    additional_query += "subjects.id IN (#{ids.uniq.join(",")})"
    query_hash[:conditions] << additional_query
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

  def load_subjects(subject)

    order = session[:_qajar_session][:subject_order] ||= 'subjects.id'

    #check if there is a current results set (i.e. something from the browser)
    unless session[:_qajar_session][:current_subjects].nil? || session[:_qajar_session][:current_subjects].empty? || !session[:_qajar_session][:current_subjects].include?(subject.id)
      subjects = Subject.where(['subjects.id IN (?)', session[:_qajar_session][:current_subjects]]).order(order)
    else
      subjects = Subject.order(order).all
    end

    subjects = sort_bilingual(subjects, session[:_qajar_session][:subject_sort_field], session[:_qajar_session][:subject_direction]) if ["name_en", "name_fa"].include?session[:_qajar_session][:subject_sort_field]
    return subjects
  end
end
