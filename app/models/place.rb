class Place < ActiveRecord::Base
  has_many :items

  translates :title

  default_scope :include => :translations
end
