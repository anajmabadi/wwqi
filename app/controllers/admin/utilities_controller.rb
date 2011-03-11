class Admin::UtilitiesController < Admin::AdminController
  
  def index
    @collections = Collection.find(:all, :order => 'collection_translations.name')
  end
  
  def reload_translations
  	  # restart passenger
  	  FileUtils.touch(File.join(RAILS_ROOT,'tmp','restart.txt'))
	  
	 respond_to do |format|
        format.html { redirect_to(admin_utilities_path, :notice => 'Server was successfully restarted.') } 
    end
  end
  
  def rebuild_item_counts
  	
  	begin
	  	# rebuild subject items counts
	  	subjects = Subject.all
	  	collections = Collection.all
	  	people = Person.all
	  	places = Place.all
	  	
	  	my_filters = [subjects, collections, people, places]
	  	
	  	my_filters.each do |my_filter|
		  	my_filter.each do |subject|
		  		item_ids = subject.items.is_published.select('items.id').map { |i| i.id.to_s }
		  		subject.item_ids_cache = item_ids.join(",")
		  		subject.items_count_cache = item_ids.size
		  		subject.save
		  	end
	  	end
	  		  	
	  	periods = Period.all
  		periods.each do |period|
	  		item_ids = Item.where(["publish = ? AND sort_year BETWEEN ? AND ?", true, period.start_at.strftime("%Y"), period.end_at.strftime("%Y")] ).select('items.id').map { |i| i.id }
	  		period.item_ids_cache = item_ids.join(",")
	  		period.items_count_cache = item_ids.size
	  		period.save
	  	end
	  	
  	rescue => error
  		flash[:error] = error.message
  	else
	  	flash[:notice] = "Caching operation succeeded."	
  	end
  	
    respond_to do |format|
      format.html { redirect_to(admin_utilities_path) }
      format.xml  { head :ok }
    end
  end
  
  def rename_by_file_name
    
    # set up the directories
    @base_dir = "/Volumes/Drobo/project_libraries/qajar_archive/"
    @pub_dir = "/Volumes/passport/project_libraries/qajar_library/"
    @input_dir = "_input/"
    @output_dir = "_output/"
    @pub_tif_dir = "pub/tif/"
    
    # set flags for successful completion
    @failed = false
    @processed_count = 0
    
    # get the images
    @images = Image.all
    
    @images.each do |image|  
      
      # skip the file if there is no original file name
      unless image.file_name.blank?
        
        # set up the uri for individual file
        @pub_file_uri = @pub_dir + @pub_tif_dir + image.tif_file_name
        @original_file_uri = @base_dir + @input_dir + image.file_name + ".tif"
        @tif_file_uri = @base_dir + @output_dir + image.tif_file_name
        
        # capture File I/O errors
        begin
          # test to see if we already have a tif of the file in the pub directory, and if so skip it
          unless File.exists?( @pub_file_uri)
            # test to see if we have a tif in the tif directory, and if so skip it
            unless File.exists?( @tif_file_uri) 
              # test that an original exists suitable for copying
              if File.exists?(@original_file_uri)
                FileUtils.cp @original_file_uri, @tif_file_uri
              end
            end
          end
        rescue StandardError => error
          flash[:error] = error
          @failed = true
        end   
      end
      @processed_count += 1
    end
  end
  
  def rename_thumbs_by_index
      
      # get the string identifying the Images
      @collection_id = params[:collection_id]
      
      unless @collection_id.nil?
        
        # get the files we need (hard codes for now)
        @items = Item.find(:all, :conditions=>["collection_id = :collection_id", {:collection_id => 12}], :order => "accession_num")
    
        unless @items.empty?
          
          # set up the directories
          @base_dir = "/Volumes/Drobo/project_libraries/qajar_archive/"
          @pub_dir = "/Volumes/passport/project_libraries/qajar_library/"
          @input_dir = "_input/"
          @output_dir = "_output/"
          @pub_thumb_dir = "pub/thumbs/"

          # set flags for successful completion
          @failed = false
          @processed_count = 1

          @items.each do |item|  
             # set up the uri for individual file
            @pub_file_uri = @pub_dir + @pub_thumb_dir + item.thumb_file_name
            @original_file_uri = @base_dir + @input_dir + "it_" + @processed_count.to_s + ".jpg"
            @output_file_uri = @base_dir + @output_dir + item.thumb_file_name

            # capture File I/O errors
            begin
              # test to see if we already have a tif of the file in the pub directory, and if so skip it
              #unless File.exists?( @pub_file_uri)
                # test to see if we have a tif in the tif directory, and if so skip it
                unless File.exists?( @output_file_uri) 
                  # test that an original exists suitable for copying
                  if File.exists?(@original_file_uri)
                    FileUtils.cp @original_file_uri, @output_file_uri
                  end
                end
              #end
            rescue StandardError => error
              flash[:error] = error
              @failed = true
            end   
            @processed_count += 1
          end
        else
          flash[:error] = "No items found for that collection id."
        end
      else
        flash[:error] = "No file identifier provided."
      end    
  end
end

  