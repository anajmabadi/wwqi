class Panel < ActiveRecord::Base
  belongs_to :exhibition
  belongs_to :item

  translates :caption

  validates :item_id, :presence => true
  validates :exhibition, :presence => true
  
end
