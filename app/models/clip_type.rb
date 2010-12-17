class ClipType < ActiveRecord::Base
  has_many :clips, :dependent => :restrict
  
  validates :name, :presence => true, :length => {:maximum => 255}, :uniqueness => true
  validates :extension, :presence => true, :length => {:maximum => 20}
  validates :publish, :presence => true
end
