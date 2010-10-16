class StaticPagesController < ApplicationController

  # hard-coded pages for the main navigation
  def page
    begin
      @page = Page.find(params[:id])
      @template = params[:page_name]
      respond_to do |format|
        format.html { render :template => "/static_pages/#{@template}.html.erb" } # /pages/about.html.erb
        format.xml  { render :xml => @page }
      end
    rescue
      handle_missing_page
    end
  end
  
  private
  
  def handle_missing_page()
    redirect_to(:controller => "home", :action => "index", :notice => t(:page_not_found))
  end
  
end
