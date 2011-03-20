class Clip < ActiveRecord::Base
  belongs_to :item
  belongs_to :clip_type
  belongs_to :owner

  # globalize2 mix-in
  translates :title, :caption, :interviewer, :interviewee, :location
  default_scope :include => [:translations]
  globalize_accessors :fa, :en
  
  # validations
  validates :item_id, :presence => true, :numericality => true
  validates :clip_type_id, :presence => true, :numericality => true
  validates :position, :presence => true, :numericality => {:greater_than => 0, :less_than => 10001}
  validates :title_en, :presence => true, :length => {:maximum => 255}
  validates :title_fa, :presence => true, :length => {:maximum => 255}
  validates :publish, :inclusion => { :in => [true,false] }
  validates :duration, :presence => true, :numericality => {:greater_than => 0}
  
  def csv_fields
    return %w[	id title_fa title_en caption_fa caption_en
    			interviewer_fa interviewer_en interviewee_fa interviewee_en
    			location_fa location_en item_title_fa item_title_en  
    			clip_type_id clip_type_name recorded_on duration 
    			owner_name position publish notes]  
  end
  
  def item_title_en
  	return self.item.title_en unless self.item.nil?
  end
  
  def item_title_fa
  	return self.item.title_fa unless self.item.nil?
  end
  
  def clip_type_name
  	return self.clip_type.name unless self.clip_type.nil?
  end
  
  def owner_name
  	return self.owner.name unless self.owner.nil?
  end
  
  
  # media file accessors from library
  def clip_file_name(format="wav")
    return "it_#{self.item_id.to_s}_#{self.position.to_s}_clip.#{format}" unless format.nil? || self.item_id.nil? || self.position.nil?
  end
  
  def clip_url(format="wav")
    return LIBRARY_URL + CLIPS_DIR + clip_file_name(format)
  end
  
end
