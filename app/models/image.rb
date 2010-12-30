class Image < ActiveRecord::Base
  belongs_to :item
  
  translates :title, :description
  globalize_accessors :fa, :en
  default_scope :include => [:translations]

  validates :title_en, :title_fa, :presence => true, :length => {:maximum => 255}  
  validates :position, :presence => true, :numericality => true
  validates :publish, :verso, :inclusion => { :in => [true,false] }
  validates :item_id, :presence => true, :uniqueness => {:scope => :position}

  def tag_line
    tag = ''
    tag += title.nil? ? item.title : title
    return tag.force_encoding("utf-8")
  end
  
  def tif_file_name
    return file_prefix + item_id.to_s + "_" + position.to_s + ".tif"
  end
  
  def file_prefix
    return "it_"
  end
end
