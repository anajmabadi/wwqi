class Appearance < ActiveRecord::Base
  belongs_to :item
  belongs_to :person

  translates :caption
  globalize_accessors :en, :fa
  default_scope :include => [:translations]
  
  def to_label
    my_label = "#{self.person_id.to_s}. #{self.person.name_fa}/#{self.person.name_en}" unless self.person.name_en.nil?
    my_label += " (#{self.caption})" unless self.caption.nil?
    return my_label
  end
end
