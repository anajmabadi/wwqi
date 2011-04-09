class HomeController < ApplicationController
  def index
    @about_page = Page.find(:first, :conditions => 'pages.id=1') || Page.new
    @featured_exhibit = Exhibition.find(:first, :conditions => 'featured=1') || Exhibition.new
    
    @limit = 12
    @item_count = Item.is_published.count
    @image_count = Image.where("publish=?", true).count
    
    @collections = Collection.where("publish = ? AND major = ?", true, true).order('last_edited').limit(@limit)
  end
end
