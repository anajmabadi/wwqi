class Owner < ActiveRecord::Base
  has_many :items, :dependent => :restrict
  has_many :collections, :through => :items
  has_many :clips, :dependent => :restrict
  has_many :repositories, :dependent => :restrict
  has_many :passports, :through => :repositories
  
  translates :name, :credit, :restrictions
  default_scope :include => :translations
  globalize_accessors :fa, :en
  
  validates :name_en, :name_fa, :presence => true, :length => {:maximum => 255}
  validates :credit_fa, :credit_en, :length => {:maximum => 255}
  validates :private, :inclusion => { :in => [true,false] }

  def self.select_list
    return self.all(:conditions => ['owner_translations.locale = ?', I18n.locale.to_s],:select => 'DISTINCT id, owner_translations.name', :order => 'owner_translations.name').map {|owner| [owner.name, owner.id]}
  end
  
  def to_label
    my_label = ''
    my_label += self.name_en unless self.name_en.nil?
    my_label += " (#{self.items.count.to_s} items)" unless self.items.empty?
    return my_label
  end
end
