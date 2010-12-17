class Clip < ActiveRecord::Base
  belongs_to :item
  belongs_to :clip_type

  # globalize2 mix-in
  translates :title, :caption
  default_scope :include => [:translations]
  globalize_accessors :fa, :en
  
  # validations
  validates :item_id, :presence => true, :numericality => true
  validates :clip_type_id, :presence => true, :numericality => true
  validates :position, :presence => true, :numericality => {:greater_than => 0, :less_than => 10001}
  validates :title_en, :presence => true, :length => {:maximum => 255}
  validates :title_fa, :presence => true, :length => {:maximum => 255}
  validates :publish, :inclusion => { :in => [true,false] }
  
  # media file accessors from library
  def clip_file_name(format="wav")
    return "it_#{self.item_id.to_s}_#{self.position.to_s}_clip.#{format}" unless format.nil? || self.item_id.nil? || self.position.nil?
  end
  
  def clip_url(format="wav")
    return LIBRARY_URL + CLIPS_DIR + clip_file_name(format)
  end
  
end
