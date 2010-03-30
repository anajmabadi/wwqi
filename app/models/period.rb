class Period < ActiveRecord::Base
  translates :title, :caption, :description
  default_scope :include => :translations
end
