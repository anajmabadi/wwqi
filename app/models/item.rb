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
  translates :title, :credit, :description, :display_date, :creator_label
  

  validates_uniqueness_of :olivia_id, :accession_num

  default_scope :include => :translations

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


  def preview_url
    return LIBRARY_URL + "previews/it_" + id.to_s + ".jpg"
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
end
