class Repository < ActiveRecord::Base
  belongs_to :owner
  has_many :passports, :order => :position
  has_many :items, :through => :passports

  # globalize
  translates :name
  globalize_accessors :fa, :en
  default_scope :include => [:translations]
  
end
