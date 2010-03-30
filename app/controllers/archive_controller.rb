class ArchiveController < ApplicationController
  def index
    @categories = Category.find(:all, :conditions => 'publish=1', :order => 'parent_id, position')
    @people = Person.find(:all, :conditions => 'publish=1', :order => 'person_translations.sort_name')
  end

end
