class HomeController < ApplicationController
  def index
    @about_page = Page.find(:first, :conditions => 'pages.id=1') || Page.new
    @featured_exhibit = Exhibition.find(:first, :conditions => 'featured=1') || Exhibition.new
  end
end
