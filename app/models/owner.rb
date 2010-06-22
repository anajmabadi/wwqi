class Owner < ActiveRecord::Base
  has_many :items
  has_many :collections, :through => :items
  translates :name
  default_scope :include => :translations

  def self.select_list
    return self.all(:conditions => ['owner_translations.locale = ?', I18n.locale.to_s],:select => 'DISTINCT id, owner_translations.name', :order => 'owner_translations.name').map {|owner| [owner.name, owner.id]}
  end
  
end
