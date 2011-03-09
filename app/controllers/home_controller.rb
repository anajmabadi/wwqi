class HomeController < ApplicationController
  def index
    @about_page = Page.find(:first, :conditions => 'pages.id=1') || Page.new
    @featured_exhibit = Exhibition.find(:first, :conditions => 'featured=1') || Exhibition.new
    
    @limit = 12
    @items = Item.where("favorite = ? AND publish = ?", true, true).order('sort_year').limit(@limit ).all
    if @items.empty? || @items.count < @limit 
    	@additional_items = Item.where("items.publish = ? AND items.id NOT IN (?)", true, @items.map { |i| i.id }.uniq.sort ).order('sort_year').limit(@limit - @items.count).all 
    end
    @items = @items | @additional_items unless @additional_items.empty?
  end
end
