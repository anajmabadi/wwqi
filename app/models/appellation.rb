class Appellation < ActiveRecord::Base
  belongs_to :person

  translates :name, :sort_name
  globalize_accessors :fa, :en
  default_scope :include => :translations
  
  
end
