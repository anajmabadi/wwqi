class Collection < ActiveRecord::Base
  has_many :items
  has_many :owners, :through => :items
  translates :name, :caption, :sort_name

  default_scope :include => :translations

  def self.select_list
    return self.all(:conditions => ['collection_translations.locale = ?', I18n.locale.to_s], :select => 'DISTINCT id, collection_translations.name', :order => 'collection_translations.name').map {|collection| [collection.name, collection.id]}
  end
  
  def self.random
    if (c = count(:conditions => "publish = 1 AND collection_translations.locale = '#{I18n.locale}'")) != 0
      find(:first, :conditions => "publish = 1 AND collection_translations.locale = '#{I18n.locale}'", :offset =>rand(c))
    end
  end

  def item_count
    items.size
  end
  
  def last_update
    Item.maximum(:created_at, :conditions => "collection_id = #{self.id} AND items.publish = 1 AND item_translations.locale = '#{I18n.locale}'")
  end

  def tag_line
    value = name
    value += ' (' + item_count + ')' unless item_count == 0
    return value
  end
      
end
