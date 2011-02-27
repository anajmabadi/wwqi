class CalendarType < ActiveRecord::Base
  has_many :items, :dependent => :restrict
  has_many :months, :dependent => :destroy, :order => :position

  validates :name_en, :name_fa, :presence => true
  validates :publish, :inclusion => { :in => [true,false] }
  
  # globalize2 accessors 
  translates :name
  globalize_accessors :fa, :en
  default_scope :include => [:translations]
  
  def self.select_list
    return self.all(:select => 'DISTINCT id, name', :order => 'name').map {|calendar_type| [calendar_type.name, calendar_type.id]}
  end
end
