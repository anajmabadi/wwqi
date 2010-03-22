class Collection < ActiveRecord::Base
  has_many :items
  has_many :owners, :through => :items
  translates :name, :caption
end
