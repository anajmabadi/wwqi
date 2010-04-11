class Place < ActiveRecord::Base
  has_many :items

  translates :name

  default_scope :include => :translations
end
