class Month < ActiveRecord::Base
  belongs_to :calendar_type
  
  # globalize2 mix-in
  translates :name
  default_scope :include => [:translations]
  globalize_accessors :fa, :en
  
  validates :name_en, :name_fa, :presence => true, :length => {:maximum => 255 }
  validates :calendar_type_id, :presence => true, :numericality => true
  validates :publish, :inclusion => { :in => [true,false] }
  
end
