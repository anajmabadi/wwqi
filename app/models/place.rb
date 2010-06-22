class Place < ActiveRecord::Base
  has_many :items

  translates :name

  default_scope :include => :translations

  def self.select_list
    return self.all(:conditions => ['place_translations.locale = ?', I18n.locale.to_s], :select => 'DISTINCT id, place_translations.name', :order => 'place_translations.name').map {|place| [place.name, place.id]}
  end
  
end
