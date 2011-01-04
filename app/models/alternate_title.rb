class AlternateTitle < ActiveRecord::Base
  belongs_to :item

  validates :item_id, :presence => true, :numericality => true
  validates :publish, :inclusion => { :in => [true,false] }

  # globalize2 accessors 
  translates :title, :caption
  globalize_accessors :fa, :en
  default_scope :include => [:translations]
  
end
