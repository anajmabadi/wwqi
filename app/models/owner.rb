class Owner < ActiveRecord::Base
  has_many :items
  has_many :collections, :through => :items
  translates :name
  default_scope :include => :translations
end
