class Section < ActiveRecord::Base
  belongs_to :item
  
  # globalize2 accessors 
  translates :title, :caption, :start_page_label, :end_page_label
  globalize_accessors :fa, :en
  default_scope :include => [:translations]
  
  validates :item_id, :presence => true, :numericality => true
  validates :start_page, :numericality => {:greater_than => 0, :less_than => 10000}
  validates :end_page, :numericality => {:greater_than => 0, :less_than => 10000}
  validates :publish, :presence => true
  
  def to_label
    return "#{self.subsection_label} #{self.title.blank? ?  ' ' : self.title + ' '}[#{self.page_range_display}]"
  end
  
  def subsection_label
    return self.subsection? ? "+  " : "-  "
  end
  
  def subsection?
    return self.parent_id.nil? || self.parent_id == self.id ? false : true
  end
  
  def page_range_display
    "#{self.start_page_display} - #{self.end_page_display}"
  end
  
  def start_page_display
    return self.start_page_label.blank? ? self.start_page.to_s : self.start_page_label
  end
  
  def end_page_display
    return self.end_page_label.blank? ? self.end_page.to_s : self.end_page_label
  end
end
