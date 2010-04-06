class HomeController < ApplicationController
  def index
    @about_page = Page.find(:first, :conditions => 'page_translations.title="About"')
  end

end
