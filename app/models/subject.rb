class Subject < ActiveRecord::Base
  translates :name
  has_many :classifications
  has_many :items, :through => :classifications, :order => :position

  validates :name, :presence => true, :length =>{:maximum => 256}
  validates :publish, :presence => true

  default_scope :include => :translations

  # pagination code
  cattr_reader :per_page
  @@per_page = 50
end
