class Era < ActiveRecord::Base
  has_many :items
  
  translates :title
  globalize_accessors :en, :fa
  default_scope :include => [:translations]
end
