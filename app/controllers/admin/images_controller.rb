class Admin::ImagesController < Admin::AdminController
  # GET /images
  # GET /images.xml
  def index
    @item = Item.find(params[:item_id])
    @images = @item.images

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @images }
    end
  end

  # GET /images/1
  # GET /images/1.xml
  def show
    @item = Item.find(params[:item_id])
    @image = Image.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @image }
    end
  end

  # GET /images/new
  # GET /images/new.xml
  def new
    @item = Item.find(params[:item_id])
    @maximum_position = @item.images.maximum(:position)
    @image = Image.new({:item_id => @item.id, 
                        :publish => true, 
                        :verso => false, 
                        :title_en => @item.title_en, 
                        :title_fa => @item.title_fa, 
                        :position => @maximum_position + 1})
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @image }
    end
  end

  # GET /images/1/edit
  def edit
    @item = Item.find(params[:item_id])
    @image = Image.find(params[:id])
  end

  # POST /images
  # POST /images.xml
  def create
    @image = Image.new(params[:image])
    @item = Item.find(params[:item_id])
    respond_to do |format|
      if @image.save
        @maximum_position = @item.images.maximum(:position)
        @item.update_attributes(:pages => @maximum_position) unless @maximum_position.nil?
        Rails.logger.info "---------- item.pages: " + @item.pages.to_s + "  @maximum_position: " + @maximum_position.to_s
        format.html { redirect_to(admin_item_image_path({:item_id => @item.id, :id => @image.id}), :notice => 'Image was successfully created.') }
        format.xml  { render :xml => @image, :status => :created, :location => @image }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @image.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /images/1
  # PUT /images/1.xml
  def update
    @image = Image.find(params[:id])
    @item = Item.find(params[:item_id])
    respond_to do |format|
      if @image.update_attributes(params[:image])
        format.html { redirect_to(admin_item_image_path({:item_id => @item.id, :id => @image.id}), :notice => 'Image was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @image.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /images/1
  # DELETE /images/1.xml
  def destroy
    @item = Item.find(params[:item_id])
    @image = Image.find(params[:id])
    @image.destroy

    respond_to do |format|
      format.html { redirect_to(admin_item_images_url) }
      format.xml  { head :ok }
    end
  end
end
