class Plot < ActiveRecord::Base
  belongs_to :item
  belongs_to :place

  validates :item_id, :presence => true, :numericality => true, :uniqueness => {:scope => :place_id}
  validates :place_id, :presence => true, :numericality => true
  validates :publish, :inclusion => { :in => [true,false] }
  validates :position, :presence => true, :numericality => true
  validates :caption_en, :caption_fa, :length => {:maximum => 255}
  
  translates :caption
  globalize_accessors :fa, :en
  default_scope :include => [:translations]
  
  def to_label
    my_label = ''
    my_label += self.place.name_en unless self.place.nil?
    my_label += " (#{self.caption_en})" unless self.caption_en.blank?
    return my_label
  end
  
  
end
