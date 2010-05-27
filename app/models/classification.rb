class Classification < ActiveRecord::Base
  belongs_to :item, :include => :translations
  belongs_to :subject, :include => :translations

  validates :item_id, :presence => true, :numericality => true
  validates :subject_id, :presence => true, :numericality => true
  validates :publish, :presence => true
  validates :position, :presence => true, :numericality => true
  validates_uniqueness_of :item_id, :scope => :subject_id

  # pagination code
  cattr_reader :per_page
  @@per_page = 50
end
