class Appellation < ActiveRecord::Base
  belongs_to :person

  translates :name, :sort_name
  globalize_accessors :fa, :en
  default_scope :include => :translations
  
  validates :name, :presence => true, :length => {:maximum => 255}
  validates :sort_name, :length => {:maximum => 255}
end
