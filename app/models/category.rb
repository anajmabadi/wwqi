class Category < ActiveRecord::Base
  translates :name, :description
  default_scope :include => :translations

  def subcategories
    return Category.find(:all, :conditions=>'publish=1 AND parent_id=' + id.to_s + ' AND parent_id<>id', :order => 'position')
  end
end
