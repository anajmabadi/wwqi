class HomeController < ApplicationController
  def index
    @about_page = Page.find(:first, :conditions => 'pages.id=1') || Page.new
    @featured_exhibit = Exhibition.find(:first, :conditions => 'featured=1') || Exhibition.new
    
    @limit = 12
    @item_count = Item.is_published.count
    @items = Item.where("publish = ?", true).order('sort_year').offset(rand(@item_count - 12).abs).limit(@limit)
    @items = @items | @additional_items unless @additional_items.nil? || @additional_items.empty?
  end
end
