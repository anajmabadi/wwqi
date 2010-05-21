class Classification < ActiveRecord::Base
  belongs_to :item
  belongs_to :subject

  validates :item_id, :presence => true, :numericality => true
  validates :subject_id, :presence => true, :numericality => true
  validates :publish, :presence => true
  validates :position, :presence => true, :numericality => true

end
