class AlternateTitle < ActiveRecord::Base
  belongs_to :item

  validates :item_id, :presence => true, :numericality => true
  validates :title_en, :presence => true
  validates :publish, :inclusion => { :in => [true,false] }

  # globalize2 accessors 
  translates :title, :caption
  globalize_accessors :fa, :en
  default_scope :include => [:translations]
  
  def to_label
    my_label = self.title_en
    my_label += " | #{self.title_fa}" unless self.title_fa.blank?
    my_label += " (#{self.id.to_s})"
    return my_label
  end
  
end
