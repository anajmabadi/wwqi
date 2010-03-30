class Collection < ActiveRecord::Base
  has_many :items
  has_many :owners, :through => :items
  translates :name, :caption, :sort_name

  default_scope :include => :translations

  def item_count
    items.size
  end

  def tag_line
    value = name
    value += ' (' + item_count + ')' unless item_count == 0
    return value
  end
end
