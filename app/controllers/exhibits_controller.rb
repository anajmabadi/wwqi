class ExhibitsController < ApplicationController
  def index
    @featured_exhibit = Exhibition.find(:first, :conditions => 'publish=1 AND featured=1')
    @exhibits = Exhibition.find(:all, :conditions => 'publish=1')
  end

  def show
    @exhibition = Exhibition.find(params[:id])
    session[:_qajar_session][:return_url] = request.fullpath
    session[:_qajar_session][:current_items] = items_set(@exhibition.items)
  end

  def detail
    @return_url = (session[:_qajar_session][:return_url].nil?) ? '/exhibits' : session[:_qajar_session][:return_url]

    begin
      @item = Item.find_by_id(params[:id])
      raise RangeError if @item.nil?
      # we need to keep the current search items here

      #get the latest result set
      unless session[:_qajar_session][:current_items].nil? || session[:_qajar_session][:current_items].length < 1 || !session[:_qajar_session][:current_items].include?(@item.id)
        @items = Item.find(session[:_qajar_session][:current_items], :order => 'item_translations.title')
      else
        @items = Item.find(:all, :conditions => "publish=1", :order => "item_translations.title" )
        # check if the item is part of the set
        raise RangeError unless @items.include?(@item)
      end
      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @collections }
      end
    rescue StandardError => error
      flash[:error] = 'Item with id number ' + params[:id].to_s + ' was not found or your item collection was invalid.'
      redirect_to @return_url
    end
  end

  private


  def items_set(items)
    return items.map { |i| i.id }
  end

end
