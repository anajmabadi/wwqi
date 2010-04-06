class Page < ActiveRecord::Base
  translates :title, :caption, :body, :author

  default_scope :include => :translations
end
