class Admin::SubjectsController < Admin::AdminController
  # GET /subjects
  # GET /subjects.xml
  def index
    # paginate the subjects
    @page = params[:page] || 1
    @per_page = params[:per_page] || Subject.per_page || 100

    @order = sort_order('UPPER(subject_translations.name)')

    # look for filters
    @keyword_filter = params[:keyword_filter] unless params[:keyword_filter] == I18n.translate(:search_prompt)
    @subject_type_filter = params[:subject_type_filter]

    @query_hash = { :conditions => ['subject_translations.locale = :selected_locale'], :parameters => {:selected_locale => 'en'} }
    @query_hash = build_subject_type_query(@subject_type_filter, @query_hash) unless @subject_type_filter.nil? || @subject_type_filter == 'all'
    @query_hash = build_keyword_query(@keyword_filter, @query_hash) unless @keyword_filter.blank? || @keyword_filter == I18n.translate(:search_prompt)

    # assemble the query from the two sql injection safe parts
    @query_conditions = ''
    @query_hash[:conditions].each do |condition|
      @query_conditions += (@query_conditions.blank? ? '': ' AND ') + condition
    end

    @query = [@query_conditions, @query_hash[:parameters]]
    
    @subjects = Subject.paginate :conditions => @query, :per_page => @per_page, :page => @page, :order => @order
    @subject_types = SubjectType.select_list

    #cache the current search set in a session variable
    session[:admin_subjects_index_url] = request.fullpath

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @subjects }
    end
  end

  # GET /subjects/1
  # GET /subjects/1.xml
  def show
    @subject = Subject.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @subject }
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
    @subject = Subject.find(params[:id])
    @subject.destroy

    respond_to do |format|
      format.html { redirect_to(admin_subjects_path) }
      format.xml  { head :ok }
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
    additional_query += "UPPER(subject_translations.name) LIKE :keyword" unless filter_value.blank?
   
    query_hash[:conditions] << additional_query
    query_hash[:parameters][:keyword] = filter_value
    return query_hash
  end
end
