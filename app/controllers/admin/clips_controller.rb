class Admin::ClipsController < Admin::AdminController
	# GET /clips
	# GET /clips.xml
	def index
		@order =  sort_order('item_id')
		@clips = Clip.includes(:item, :clip_type).order(@order)
		respond_to do |format|
			format.html # index.html.erb
			format.xml  { render :xml => @clips }
		end
	end

	def export
		begin
			@order =  sort_order('item_id')
			@clips = Clip.includes(:item, :clip_type).order(@order)
		rescue => error
			flash[:error] = "There was a problem finding clips: " + error.message
			@error = true
		end

		respond_to do |format|
			format.html { redirect_to admin_clips_path, :error => flash[:error] }
			format.csv do
				csv_string = make_custom_csv(@clips)
				# send it to the browsah
				send_data csv_string,
                :type => 'text/csv; charset=utf-8; header=present',
                :disposition => "attachment; filename=clips.csv"
			end
			format.xml  { render :xml => @clips }
		end

	end

	# GET /clips/1
	# GET /clips/1.xml
	def show
		@clip = Clip.find(params[:id])

		respond_to do |format|
			format.html # show.html.erb
			format.xml  { render :xml => @clip }
		end
	end

	# GET /clips/new
	# GET /clips/new.xml
	def new
		@clip = Clip.new
		@items = items_list
		@owners = Owner.select_list
		@clip_types = clip_types_list
		respond_to do |format|
			format.html # new.html.erb
			format.xml  { render :xml => @clip }
		end
	end

	# GET /clips/1/edit
	def edit
		@clip = Clip.find(params[:id])
		@items = items_list
		@owners = Owner.select_list
		@clip_types = clip_types_list
	end

	# POST /clips
	# POST /clips.xml
	def create
		@clip = Clip.new(params[:clip])
		@items = items_list
		@clip_types = clip_types_list
		@owners = Owner.select_list
		respond_to do |format|
			if @clip.save
				format.html { redirect_to(admin_clip_path(@clip), :notice => 'Clip was successfully created.') }
				format.xml  { render :xml => @clip, :status => :created, :location => @clip }
			else
				format.html { render :action => "new" }
				format.xml  { render :xml => @clip.errors, :status => :unprocessable_entity }
			end
		end
	end

	# PUT /clips/1
	# PUT /clips/1.xml
	def update
		@clip = Clip.find(params[:id])
		@items = items_list
		@clip_types = clip_types_list
		@owners = Owner.select_list
		respond_to do |format|
			if @clip.update_attributes(params[:clip])
				format.html { redirect_to(admin_clip_path(@clip), :notice => 'Clip was successfully updated.') }
				format.xml  { head :ok }
			else
				format.html { render :action => "edit" }
				format.xml  { render :xml => @clip.errors, :status => :unprocessable_entity }
			end
		end
	end

	# DELETE /clips/1
	# DELETE /clips/1.xml
	def destroy
		@clip = Clip.find(params[:id])
		@clip.destroy

		respond_to do |format|
			format.html { redirect_to(admin_clips_path) }
			format.xml  { head :ok }
		end
	end

	private

	def items_list
		return Item.select(['item_translations.title', 'items.id']).order('items.id').map { |i| [ "#{i.id.to_s}: #{ i.title}", i.id] }
	end

	def clip_types_list
		return ClipType.select(['name', 'id']).order('name').map { |c| [c.name, c.id] }
	end
end
