class Category < ActiveRecord::Base
  has_many :items

  translates :name, :description
  default_scope :include => :translations

  def subcategories
    return Category.find(:all, :conditions=>'publish=1 AND parent_id=' + id.to_s + ' AND parent_id<>id', :order => 'position')
  end
  
  def query_ids
    ids = subcategories.map { |i| i.id }
    ids.push(id)
    return ids
  end
end
