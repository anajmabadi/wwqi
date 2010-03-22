class Category < ActiveRecord::Base
  translates :name, :description
  default_scope :include => :translations
end
