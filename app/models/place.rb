class Place < ActiveRecord::Base
  has_many :items

  has_many :plots, :order => 'plots.position'
  has_many :items, :through => :plots, :order => 'plots.position', :as => :related_items

  translates :name
  globalize_accessors :fa, :en
  default_scope :include => :translations

  def self.select_list
    return self.all(:conditions => ['place_translations.locale = ?', I18n.locale.to_s], :select => 'DISTINCT id, place_translations.name', :order => 'place_translations.name').map {|place| [place.name, place.id]}
  end
  
end
