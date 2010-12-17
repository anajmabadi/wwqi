class Appearance < ActiveRecord::Base
  belongs_to :item
  belongs_to :person

  translates :caption
  globalize_accessors :en, :fa
  default_scope :include => [:translations]
  
  validates :publish, :inclusion => { :in => [true,false] }
  validates :person_id, :presence => true, :uniqueness => {:scope => :item_id}
  validates :item_id, :presence => true
  validates :position, :presence => true, :numericality => {:greater_than_or_equal_to => 0}
  
  def to_label
    my_label = self.person.to_label unless self.person.nil?
    my_label += " (#{self.caption})" unless self.caption.blank?
    return my_label
  end
end
