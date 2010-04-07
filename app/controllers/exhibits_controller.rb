class ExhibitsController < ApplicationController
  def index
    @featured_exhibit = Exhibition.find(:first, :conditions => 'publish=1 AND featured=1')
    @exhibits = Exhibition.find(:all, :conditions => 'publish=1')
  end

  def show
  end

end
