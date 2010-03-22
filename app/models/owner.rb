class Owner < ActiveRecord::Base
  has_many :items
  has_many :collections, :through => :items
  translates :name
end
