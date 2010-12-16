class ClipType < ActiveRecord::Base
  has_many :clips, :dependent => :restrict
end
