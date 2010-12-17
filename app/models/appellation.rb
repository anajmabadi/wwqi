class Appellation < ActiveRecord::Base
  belongs_to :person

  translates :name, :sort_name
  globalize_accessors :fa, :en
  default_scope :include => :translations
  
  validates :name_en, :presence => true, :length => {:maximum => 255}
  validates :sort_name_en, :length => {:maximum => 255}
  validates :name_fa, :presence => true, :length => {:maximum => 255}
  validates :sort_name_fa, :length => {:maximum => 255}
  validates :position, :presence => true, :numericality => {:greater_than => 0}
  validates :publish, :inclusion => { :in => [true,false] }
  validates :person_id, :presence => true
end
