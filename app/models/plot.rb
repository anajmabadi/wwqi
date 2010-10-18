class Plot < ActiveRecord::Base
  belongs_to :item
  belongs_to :place

  validates :item_id, :presence => true, :numericality => true
  validates :place_id, :presence => true, :numericality => true
  
end