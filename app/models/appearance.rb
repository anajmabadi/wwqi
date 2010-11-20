class Appearance < ActiveRecord::Base
  belongs_to :item
  belongs_to :person

  translates :caption
  globalize_accessors :en, :fa
  default_scope :include => [:translations]
end
