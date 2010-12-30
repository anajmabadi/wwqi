class Item < ActiveRecord::Base

  before_validation :set_sensible_date_defaults
  
  # truncate and other helpers
  include ActionView::Helpers::TextHelper
  include ApplicationHelper


  belongs_to :owner
  belongs_to :collection, :counter_cache => true
  belongs_to :format
  belongs_to :medium
  belongs_to :calendar_type
  belongs_to :creator, :class_name => "Person", :foreign_key => :creator_id
  belongs_to :era

  has_many :classifications, :dependent => :destroy
  has_many :images, :order => :position, :dependent => :destroy
  has_many :appearances, :dependent => :destroy
  has_many :people, :through => :appearances
  has_many :plots, :order => 'plots.position', :dependent => :destroy
  has_many :places, :through => :plots, :order => 'plots.position'
  has_many :panels, :dependent => :destroy
  has_many :exhibitions, :through => :panels, :order => 'panels.position'
  has_many :clips, :order => :position, :dependent => :destroy
  has_many :subjects, :through => :classifications, :order => 'position'
  has_many :passports, :order => 'passports.position', :dependent => :destroy
  has_many :repositories, :through => :passports
  has_many :comps, :order => 'comps.position', :dependent => :destroy  #join table for linking objects to each other -- must be specified in both directions
  has_many :sections, :order => 'sections.start_page', :dependent => :destroy
  
  # globalize2 accessors 
  translates :title, :credit, :description, :display_date, :creator_label, :publisher, :transcript, :remarks
  globalize_accessors :fa, :en
  default_scope :include => [:translations]
  
  # pagination code
  cattr_reader :per_page
  @@per_page = 100

  
  # validations
   validates :accession_num, :presence => true, :length => { :maximum => 255, :minimum => 3 }
   
  def create_images
    if self.images.empty? && !self.pages.nil? && self.pages != 0
      (1..self.pages).each do |index|
        image = Image.create(:item_id => self.id, :position => index, :publish => true, :verso => false, :title_en => self.title_en, :title_fa => self.title_fa)
      end  
    end
    return self.images(true)
  end

  def self.recently_added_ids(limit=25)
    ids = []
    months = 1
    until ids.size >= limit || months > 12 do
      ids = Item.added_since_date(months, limit)
      months += 1
    end
    return ids
  end 
  
  def absolute_date
    begin
      my_month = self.month.blank? || self.month == 0 ? 1 : self.month
      my_day = self.day.blank? || self.day == 0 ? 1 : self.day
      my_year = self.year.blank? || self.year == 0 ? 2010 : self.year
      
      case self.calendar_type_id 
        when 1 then Calendar.absolute_from_gregorian(my_month, my_day, my_year) 
        when 2 then Calendar.absolute_from_islamic(my_month, my_day, my_year) 
        when 3 then Calendar.absolute_from_jalaali(my_month, my_day, my_year) 
        else Calendar.absolute_from_gregorian(my_month, my_day, my_year) 
      end
    rescue StandardError => e
      nil
    end   
  end
  
  def gregorian_date
    begin
      Calendar.gregorian_from_absolute(self.absolute_date)
    rescue StandardError => e
      nil
    end 
  end
  
  def islamic_date
    begin
      Calendar.islamic_from_absolute(self.absolute_date)
    rescue StandardError => e
      nil
    end 
  end
  
  def jalali_date
    begin
      Calendar.jalaali_from_absolute(self.absolute_date)
    rescue StandardError => e
      nil
    end 
  end
  
  def self.added_since_date(months=1, limit=25)
    ids = Item.find(:all, :select => 'items.id', :conditions => ["items.publish = ? AND item_translations.locale=? AND items.created_at >= ?", 1, I18n.locale.to_s, Time.now.months_ago(months)], :order => 'items.created_at DESC', :limit => limit).map { |item| item.id }
    return ids
  end   

  def self.most_popular(limit=100)
    if @popular_items.nil? || @popular_refreshed_at > 1.day.ago
      @popular_ids = Item.most_popular_ids(limit)
      unless @popular_ids.nil? || @popular_ids.empty?
        @popular_items = Item.find(:all, :conditions => "items.id IN (#{@popular_ids.join(",")}) AND items.publish = 1 AND item_translations.locale='#{I18n.locale.to_s}'", :limit => limit)
      else
        @popular_items = []
      end  
    end
    if @popular_items.size < limit
      @popular_items += Item.find(:all, :conditions => "items.publish = 1 AND item_translations.locale='#{I18n.locale.to_s}'", :limit => (limit - @popular_items.size))
    end
    @popular_refreshed_at = DateTime.now  
    return @popular_items
  end
  
  def self.most_popular_ids(limit=100)
    return Activity.find(:all, :group => 'item_id', :select => 'count(*) count, item_id', :conditions => "item_id IS NOT NULL", :order => 'count', :limit => limit).map { |ids| ids.item_id }
  end
  
  def self.recently_viewed(limit=8)
    if @recently_viewed_items.nil? || @recently_refreshed_at > 1.minute.ago
      @recently_viewed_ids = Item.most_recent_ids(limit)
      unless @recently_viewed_ids.nil? || @recently_viewed_ids.empty?
        @recently_viewed_items = Item.find(:all, :conditions => "items.id IN (#{@recently_viewed_ids.join(",")}) AND items.publish = 1 AND item_translations.locale='#{I18n.locale.to_s}'")
      else
        @recently_viewed_items = []
      end  
    end
    if @recently_viewed_items.size < limit
      @recently_viewed_items += Item.find(:all, :conditions => "items.publish = 1 AND item_translations.locale='#{I18n.locale.to_s}'", :limit => (limit - @recently_viewed_items.size))
    end  
    @recently_refreshed_at = DateTime.now
    return @recently_viewed_items
  end

  def self.most_recent_ids(limit=8)
    return Activity.find(:all, :select => 'DISTINCT item_id', :conditions => "item_id IS NOT NULL", :order => 'created_at DESC', :limit => limit).map { |ids| ids.item_id }
  end

  def oral_history_class
    return "oralhistory" unless self.clips.empty?
  end

  def show_date
    date_to_show = ''
    if !self.display_date.blank?
      date_to_show += display_date
    elsif !self.sort_year.blank?
      date_to_show += sort_year.to_s
    end
    
    # check for editorial
    if self.editorial_date
      date_to_show = "[#{date_to_show}]"
    end
    return I18n.translate(:circa) + ' ' +  date_to_show if self.circa && date_to_show != ''
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

  def slide_file_name(index=1)
    return FILE_PREFIX + "#{self.id.to_s}_#{index.to_s}.jpg" unless index.nil?
  end

  def slide_url(index=1)
    return LIBRARY_URL + SLIDES_DIR + slide_file_name(index) unless index.nil?
  end

  def slide_urls
    file_urls = Array.new
    (1..self.pages).each do |page|
      file_urls << slide_url(page)
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
  
  def tif_path(index=1)
    return LIBRARY_PATH + TIFS_DIR + tif_file_name(index) unless index.nil?
  end
  
  def tif_paths
    file_urls = Array.new
    (1..self.pages).each do |page|
      file_urls << tif_path(page)
    end unless self.pages.nil?
    return file_urls
  end
  
  def zip_file_name()
    return FILE_PREFIX + "#{self.id.to_s}.zip"
  end
  
  def zip_url()
    return LIBRARY_URL + ZIPS_DIR + zip_file_name()
  end
  
  def zip_path()
    return LIBRARY_PATH + ZIPS_DIR + zip_file_name()
  end
  
  def zoomify_folder_name(index=1)
    return "it_#{self.id.to_s}_#{index.to_s}_img" unless index.nil?
  end
  
  def zoomify_url(index=1)
    return LIBRARY_URL + ZOOMIFY_DIR + zoomify_folder_name(index) unless index.nil?
  end
  
  def dimension_label
    dimensions_set = []
    dimensions_set << localize_number(floatstrip(self.width)) unless self.width.nil? || self.width == 0
    dimensions_set << localize_number(floatstrip(self.height)) unless self.height.nil? || self.height == 0
    dimensions_set << localize_number(floatstrip(self.depth)) unless self.depth.nil? || self.depth == 0
    label = dimensions_set.join(" #{I18n.translate(:dimension_separator)} ") + ' ' + I18n.translate(:dimension_unit) unless dimensions_set.empty?
    return label
  end

  def to_label
    return truncate(self.title, :length => 60) + " (#{self.id.to_s})"
  end


  def self.select_list
    return self.all(:conditions => ['item_translations.locale = ?', I18n.locale.to_s], :select => 'DISTINCT id, item_translations.title', :order => 'item_translations.title').map {|item| [item.to_label, item.id]}
  end
  
  private
  
  def localize_number(number=0)
    return I18n.locale == :fa ? number.to_farsi : number.to_s
  end

  def set_sensible_date_defaults
    
    # set the source year if needed
    if self.year.blank? && !self.era.nil?
      self.year = self.era.year 
      self.calendar_type_id = 1
    end
      
    if self.sort_year.blank?
      # check source years
      unless self.year.blank?
        my_sort_date = self.gregorian_date
        self.sort_year = my_sort_date[2]
        self.sort_month = my_sort_date[0]
        self.sort_day = my_sort_date[1]
      else
        unless self.era.nil?
          self.sort_year = self.era.year
        else
          # no date
          self.sort_year = 2050
        end
      end
    end
    
    
  end
end
