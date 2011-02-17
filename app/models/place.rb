class Place < ActiveRecord::Base

  has_many :plots, :order => 'plots.position', :dependent => :destroy
  has_many :items, :through => :plots, :order => 'plots.position'

  translates :name
  globalize_accessors :fa, :en
  default_scope :include => :translations

  def self.select_list
    return self.all(:conditions => ['place_translations.locale = ?', I18n.locale.to_s], :select => 'DISTINCT id, place_translations.name', :order => 'place_translations.name').map {|place| [place.name, place.id]}
  end
  
  def items_count(item_ids=nil)
  	begin
    	count = item_ids.nil? ? self.items.is_published.count : count = self.items.is_published.where("items.id IN (?)", item_ids).count
   	rescue => error
   		count = 0
   	end
   	return count
  end
end
