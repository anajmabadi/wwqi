class Repository < ActiveRecord::Base


  include ActionView::Helpers::TextHelper
  
  belongs_to :owner
  has_many :passports, :order => :position
  has_many :items, :through => :passports

  # globalize
  translates :name
  globalize_accessors :fa, :en
  default_scope :include => [:translations]

  def to_label
    return truncate(self.name) + " (#{self.id.to_s})"
  end
  
end
