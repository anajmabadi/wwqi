class Place < ActiveRecord::Base

  has_many :plots, :order => 'plots.position', :dependent => :destroy
  has_many :items, :through => :plots, :order => 'plots.position'

  translates :name
  globalize_accessors :fa, :en
  default_scope :include => :translations

  def csv_fields
    return %w[	id name_fa name_en publish major notes]  
  end
  
  def self.select_list
    return self.all(:conditions => ['place_translations.locale = ?', I18n.locale.to_s], :select => 'DISTINCT id, place_translations.name', :order => 'place_translations.name').map {|place| [place.name, place.id]}
  end
  
  def related_item_ids_cache
  	return self.item_ids_cache.split(",").map { |i| i.to_i }.sort unless self.item_ids_cache.nil?
  end
  
  def items_count(item_ids=nil)
    begin
    # cache the values
	      if self.items_count_cache.nil? || self.item_ids_cache.nil?
	        self.item_ids_cache = self.items.is_published.select('items.id').order('items.id').all.map { |i| i.id }.join(",")
	      self.items_count_cache = self.related_item_ids_cache.size
	      end
	      count = item_ids.nil? ? self.items_count_cache : (self.related_item_ids_cache & item_ids).size
    rescue => error
	    count = 0
    end
    return count
  end
  
end
