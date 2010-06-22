class Collection < ActiveRecord::Base
  has_many :items
  has_many :owners, :through => :items
  translates :name, :caption, :sort_name

  default_scope :include => :translations

  def self.select_list
    return self.all(:conditions => ['collection_translations.locale = ?', I18n.locale.to_s], :select => 'DISTINCT id, collection_translations.name', :order => 'collection_translations.name').map {|collection| [collection.name, collection.id]}
  end

  def item_count
    items.size
  end

  def tag_line
    value = name
    value += ' (' + item_count + ')' unless item_count == 0
    return value
  end
end
