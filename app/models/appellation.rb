class Appellation < ActiveRecord::Base
  belongs_to :person

  translates :name, :sort_name
  globalize_accessors :fa, :en
  default_scope :include => :translations
  
  validates :name, :presence => true, :length => {:maximum => 255}
  validates :sort_name, :length => {:maximum => 255}
  validates :position, :presence => true, :numericality => {:greater_than => 0}
  validates :publish, :presence => true
  validates :person_id, :presence => true
end
