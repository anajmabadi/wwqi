class Repository < ActiveRecord::Base


  include ActionView::Helpers::TextHelper
  
  belongs_to :owner
  has_many :passports, :order => :position, :dependent => :destroy
  has_many :items, :through => :passports

  # globalize
  translates :name
  globalize_accessors :fa, :en
  default_scope :include => [:translations]
  
  validates :name_en, :presence => true, :length => {:maximum => 255} 
  validates :name_fa, :presence => true, :length => {:maximum => 255} 
  validates :url, :presence => true, :length => {:maximum => 255}, :uniqueness => true
  validates :publish, :inclusion => { :in => [true,false] }
  validates :owner_id, :numericality => true, :presence => true

  def to_label
    return truncate(self.name) + " (#{self.id.to_s})"
  end
  
end
