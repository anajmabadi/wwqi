class Owner < ActiveRecord::Base
  has_many :items, :dependent => :restrict
  has_many :collections, :through => :items
  has_many :clips, :dependent => :restrict
  has_many :repositories, :dependent => :restrict
  has_many :passports, :through => :repositories
  
  translates :name
  default_scope :include => :translations
  globalize_accessors :fa, :en

  def self.select_list
    return self.all(:conditions => ['owner_translations.locale = ?', I18n.locale.to_s],:select => 'DISTINCT id, owner_translations.name', :order => 'owner_translations.name').map {|owner| [owner.name, owner.id]}
  end
  
end
