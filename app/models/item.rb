class Item < ActiveRecord::Base
  belongs_to :owner
  belongs_to :collection
  belongs_to :format
  belongs_to :medium
  belongs_to :place
  belongs_to :period
  belongs_to :category
  belongs_to :calendar_type
  has_many :images
  has_many :appearances
  has_many :people, :through => :appearances
  has_many :panels
  has_many :exhibitions, :through => :panels, :order => 'panels.position'
  has_many :clips, :order => :position
  
  translates :title, :credit, :description, :display_date, :creator_label
  
  # pagination code
  cattr_reader :per_page
  @@per_page = 25
  
  validates_uniqueness_of :olivia_id, :accession_num

  default_scope :include => [:translations, :category]

  # a convenience function for matching up item types with hard coded icon classes
  def icon_class
    return case category.parent_id
    when 1 then 'writing'
    when 2 then 'legal'
    when 3 then 'artwork'
    when 4 then 'photo'
    when 5 then 'object'
    when 6 then 'oralhistory'
    else 'object'
    end unless category_id.nil? || category.nil?
  end

  def show_date
    unless display_date.blank?
      return display_date
    else
      return sort_date.to_s
    end
  end

  def thumbnail_url
    return LIBRARY_URL + 'thumbs/it_' + id.to_s + ".jpg"
  end


  def preview_url(index=1)
    return LIBRARY_URL + "previews/it_#{id.to_s}_#{index.to_s}.jpg"
  end

  def tif_url
    return LIBRARY_URL + id.to_s + ".tif"
  end

  def zoomify_url(index=1)
    return LIBRARY_URL + "zoomify/it_#{id.to_s}_#{index.to_s}_img"
  end

  def slides_xml_url
    return '/collections/detail/' + id.to_s + '/slides.xml'
  end

  def clip_url(index=1)
    return LIBRARY_URL + "clips/it_#{id.to_s}_#{index.to_s}_clip.wav"
  end
end
