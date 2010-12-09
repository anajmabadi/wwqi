class Section < ActiveRecord::Base
  belongs_to :item
  
  # globalize2 accessors 
  translates :title, :caption, :start_page_label, :end_page_label
  globalize_accessors :fa, :en
  default_scope :include => [:translations]
  
  validates :item_id, :presence => true, :numericality => true
  validates :title, :presence => true
  validates :start_page, :numericality => {:greater_than => 0, :less_than => 10000}
  validates :end_page, :numericality => {:greater_than => 0, :less_than => 10000}
  validates :publish, :presence => true
  
end
