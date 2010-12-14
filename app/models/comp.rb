class Comp < ActiveRecord::Base
  belongs_to :item
  belongs_to :comp, :class_name => 'Item'

  validates :item_id, :presence => true, :numericality => true, :item_comp_different => true
  validates :comp_id, :presence => true, :numericality => true
  validates :position, :presence => true, :numericality => true
  validates :publish, :presence => true

  translates :caption
  globalize_accessors :en, :fa
  default_scope :include => :translations
  
  def to_label
    mylabel = ''
    mylabel += self.comp.title unless self.comp.nil?
    mylabel += " (#{self.caption })" unless self.caption.blank? 
    return mylabel
  end
end
