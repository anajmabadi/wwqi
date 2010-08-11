class Item < ActiveRecord::Base
  belongs_to :owner
  belongs_to :collection
  belongs_to :format
  belongs_to :medium
  belongs_to :place
  belongs_to :period, :counter_cache => true
  belongs_to :category
  belongs_to :calendar_type
  belongs_to :creator, :class_name => "Person", :foreign_key => :creator_id

  has_many :classifications
  has_many :images
  has_many :appearances
  has_many :people, :through => :appearances
  has_many :panels
  has_many :exhibitions, :through => :panels, :order => 'panels.position'
  has_many :clips, :order => :position
  has_many :subjects, :through => :classifications, :order => 'position'
  
  # globalize2 accessors 
  translates :title, :credit, :description, :display_date, :creator_label
  globalize_accessors :fa, :en
  default_scope :include => [:translations, :category]
  
  # pagination code
  cattr_reader :per_page
  @@per_page = 25
  attr_accessor :popular_items
  attr_accessor :recently_viewed
  attr_accessor :popular_refreshed_at
  attr_accessor :recently_refreshed_at
  
  # validations
  validates :title, :presence => true, :length => { :maximum => 255, :minimum => 3 }
  validates :pages, :presence => true, :numericality => { :greater_than => 0, :less_than => 10001 }
  validates :accession_num, :presence => true, :length => { :maximum => 255, :minimum => 3 }

  def self.most_popular(limit=8)
    if @popular_items.nil? || @popular_refreshed_at > 1.day.ago
      @popular_ids = Activity.find(:all, :group => 'item_id', :select => 'count(*) count, item_id', :order => 'count', :limit => limit).map { |ids| ids.item_id }
      @popular_items = Item.find(@popular_ids)
    end
    if @popular_items.size < limit
      @popular_items += Item.find(:all, :limit => (limit - @popular_items.size))
    end
    @popular_refreshed_at = DateTime.now  
    return @popular_items
  end
  
  def self.recently_viewed(limit=8)
    if @recently_viewed_items.nil? || @recently_refreshed_at > 1.minute.ago
      @recently_viewed_ids = Activity.find(:all, :conditions => 'item_ID IS NOT NULL', :select => 'DISTINCT item_id', :order => 'created_at DESC', :limit => limit).map { |ids| ids.item_id }
      @recently_viewed_items = Item.find(@recently_viewed_ids)
    end
    if @recently_viewed_items.size < limit
      @recently_viewed_items += Item.find(:all, :limit => (limit - @recently_viewed_items.size))
    end  
    @recently_refreshed_at = DateTime.now
    return @recently_viewed_items
  end
  
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

  # TODO: Find the right place for this special XML route
  def slides_xml_url
    return '/archive/detail/' + id.to_s + '/slides.xml'
  end

  # Library media file accessors
  def thumbnail_file_name
    return FILE_PREFIX + id.to_s + ".jpg"
  end
  
  def thumbnail_url
    return LIBRARY_URL + THUMBNAILS_DIR + thumbnail_file_name
  end
  
  def preview_file_name(index=1)
    return FILE_PREFIX + "#{self.id.to_s}_#{index.to_s}.jpg" unless index.nil?
  end

  def preview_url(index=1)
    return LIBRARY_URL + PREVIEWS_DIR + preview_file_name(index) unless index.nil?
  end
  
  def preview_urls
    file_urls = Array.new
    (1..self.pages).each do |page|
      file_urls << preview_url(page)
    end unless self.pages.nil?
    return file_urls
  end
  
  def tif_file_name(index=1)
    return FILE_PREFIX + "#{self.id.to_s}_#{index.to_s}.tif" unless index.nil?
  end
  
  def tif_url(index=1)
    return LIBRARY_URL + TIFS_DIR + tif_file_name(index) unless index.nil?
  end

  def tif_urls
    file_urls = Array.new
    (1..self.pages).each do |page|
      file_urls << tif_url(page)
    end unless self.pages.nil?
    return file_urls
  end

  def zoomify_folder_name(index=1)
    return "it_#{self.id.to_s}_#{index.to_s}_img" unless index.nil?
  end
  
  def zoomify_url(index=1)
    return LIBRARY_URL + ZOOMIFY_DIR + zoomify_folder_name(index) unless index.nil?
  end

end
