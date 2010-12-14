class Appearance < ActiveRecord::Base
  belongs_to :item
  belongs_to :person

  translates :caption
  globalize_accessors :en, :fa
  default_scope :include => [:translations]
  
  def to_label
    my_label = self.person.to_label unless self.person.nil?
    my_label += " (#{self.caption})" unless self.caption.blank?
    return my_label
  end
end
