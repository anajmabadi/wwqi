class ContactController < ApplicationController
    # GET /comments
    # GET /comments.xml
    def index
        @comment = Comment.new
        @ip = request.remote_ip
        @page = Page.find(params[:id])

        respond_to do |format|
            format.html # index.html.erb
            format.xml  { render :xml => @comments }
        end
    end

    def confirm
        @comment = Comment.find(params[:id])

        respond_to do |format|
            format.html # show.html.erb
            format.xml  { render :xml => @comment }
        end
    end

    # GET /comments/new
    # GET /comments/new.xml
    def new
        @comment = Comment.new

        respond_to do |format|
            format.html # new.html.erb
            format.xml  { render :xml => @comment }
        end
    end

    # GET /comments/1/edit
    def edit
        @comment = Comment.find(params[:id])
    end

    # POST /comments
    # POST /comments.xml
    def create
        @comment = Comment.new(params[:comment])

        respond_to do |format|
            if @comment.save
                format.html { redirect_to(:action => 'confirm', :notice => 'Comment was successfully created.', :id => @comment) }
                format.xml  { render :xml => @comment, :status => :created, :location => @comment }
            else
                format.html { render :action => "new" }
                format.xml  { render :xml => @comment.errors, :status => :unprocessable_entity }
            end
        end
    end

    # PUT /comments/1
    # PUT /comments/1.xml
    def update
        @comment = Comment.find(params[:id])

        respond_to do |format|
            if @comment.update_attributes(params[:comment])
                format.html { redirect_to(admin_comment_path(@comment), :notice => 'Comment was successfully updated.') }
                format.xml  { head :ok }
            else
                format.html { render :action => "edit" }
                format.xml  { render :xml => @comment.errors, :status => :unprocessable_entity }
            end
        end
    end

end
