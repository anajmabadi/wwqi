class Relationship < ActiveRecord::Base
  belongs_to :person
  belongs_to :relative, :class_name => "Person", :foreign_key => "relative_id"

  translates :name, :description
  default_scope :include => :translations
  globalize_accessors :fa, :en
  
end
