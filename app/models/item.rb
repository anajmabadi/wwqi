class Item < ActiveRecord::Base

  before_validation :set_sensible_date_defaults
  after_create :create_images
  
  # truncate and other helpers
  include ActionView::Helpers::TextHelper
  include ApplicationHelper

  belongs_to :owner
  belongs_to :collection
  belongs_to :format
  belongs_to :medium
  belongs_to :calendar_type
  belongs_to :creator, :class_name => "Person", :foreign_key => :creator_id
  belongs_to :era
  
  has_many :alternate_titles, :dependent => :destroy
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
  has_many :comps, :order => 'comps.position', :dependent => :destroy  
  has_many :sections, :order => 'sections.start_page', :dependent => :destroy
  
  # globalize2 accessors 
  translates :title, :credit, :description, :display_date, :creator_label, :published, :transcript, :remarks, :owner_tag
  globalize_accessors :fa, :en
  default_scope :include => [:translations]
  
  # pagination code
  cattr_reader :per_page
  @@per_page = 100

  
  # validations
  validates :accession_num, :presence => true, :length => { :maximum => 255, :minimum => 3 }, :uniqueness => true
  validates :pages, :presence => true, :numericality => {:greater_than => 0, :less_than => 10001 }
  validates :width, :height, :depth, :presence => true, :numericality => true
  validates :publish, :bound, :favorite, :editorial_date, :circa, :inclusion => { :in => [true,false] }
   
   
  def csv_fields
    return %w[id accession_num bound calendar_type_id circa collection_id collection_name_en collection_name_fa created_at day depth editorial_date editorial_dating era_id favorite format_id height id lock_version month notes owner_id owner_name_en owner_name_fa owner_tag pages publish sort_day sort_month sort_year source_date updated_at urn width year display_date_en description_en title_en credit_en creator_label_en publisher_en transcript_en remarks_en display_date_fa description_fa title_fa credit_fa creator_label_fa publisher_fa transcript_fa remarks_fa concept_list genre_list person_list place_list comp_list has_clip?]
  end 
  
  def owner_name
    return self.owner.name unless self.owner.nil?
  end
  
  def collection_name
    return self.collection.name unless self.collection.nil?
  end  
  
  def concept_list
    return self.subjects.where("subject_type_id=7").map { |subject| subject.to_label }.join(", ") unless self.subjects.empty?
  end
  
  def genre_list
    return self.subjects.where("subject_type_id=8").map { |subject| subject.to_label }.join(", ") unless self.subjects.empty?
  end
  
  def person_list
    return self.people.map { |person| "#{person.name} (#{person.id})" }.join(", ") unless self.people.empty?
  end
  
  def place_list
    return self.places.map { |place| "#{place.name} (#{place.id})" }.join(", ") unless self.places.empty?
  end
  
  def comp_list
    return self.comps.map { |comp| comp.item.to_label }.join(", ") unless self.comps.empty?
  end
  
  def has_clip?
    return !self.clips.empty?
  end
  
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
  
  def gregorian_year_range
    possible_years = []  
    self.day = 1  
    (1..12).each do |month|
      self.month = month
      gregorian_year = self.gregorian_date[2]
      possible_years.push( gregorian_year ) unless possible_years.include?(gregorian_year)
    end
    self.day = nil
    self.month = nil
    return possible_years 
  end
  
  def localize_year_range_label(year_range=[])
    return year_range.map { |year| localized_number(year) }.join(" #{I18n.translate(:year_range_separator)} ")
  end
  
  def gregorian_date
    begin
      Calendar.gregorian_from_absolute(self.absolute_date)
    rescue StandardError => e
      nil
    end 
  end
  
  def gregorian_date_label
    my_label = ''  
    unless self.gregorian_date.nil? || self.gregorian_date.empty? 
      my_label += localized_number(self.gregorian_date[1]) + " " unless self.day.blank?
      my_label += Month.where('calendar_type_id=? AND publish=? AND position = ?', 1, true, self.gregorian_date[0]).first.name  + " " unless self.month.blank?
      if my_label == ''
        #we have just a year and need to show year range
        my_label += localize_year_range_label(self.gregorian_year_range) unless self.year.blank?
      else
        my_label += localized_number(self.gregorian_date[2]) unless self.year.blank?
      end
    end
    return my_label
  end
  
  def islamic_date
    begin
      Calendar.islamic_from_absolute(self.absolute_date)
    rescue StandardError => e
      nil
    end 
  end
  
  def islamic_date_label
   my_label = ''  
   unless self.islamic_date.nil? || self.islamic_date.empty? 
      my_label += localized_number(self.islamic_date[1]) + " " unless self.day.blank?
      my_label += Month.where('calendar_type_id=? AND publish=? AND position = ?', 2, true, self.islamic_date[0]).first.name + " " unless self.month.blank?
      if my_label == ''
        my_label += localize_year_range_label(self.islamic_year_range)
      else
        my_label += localized_number(self.islamic_date[2]) unless self.year.blank?
      end
    end
    return my_label
  end
  
  def islamic_year_range
    possible_years = []  
    self.day = 1  
    (1..12).each do |month|
      self.month = month
      islamic_year = self.islamic_date[2]
      possible_years.push( islamic_year ) unless possible_years.include?(islamic_year)
    end
    self.day = nil
    self.month = nil
    return possible_years 
  end
  
  def jalali_date
    begin
      Calendar.jalaali_from_absolute(self.absolute_date)
    rescue StandardError => e
      nil
    end 
  end
  
  def jalali_date_label
   my_label = ''  
   unless self.jalali_date.nil? || self.jalali_date.empty? 
      my_label += localized_number(self.jalali_date[0]) + " " unless self.day.blank?
      my_label += Month.where('calendar_type_id=? AND publish=? AND position = ?', 3, true, self.jalali_date[0]).first.name  + " " unless self.month.blank?
      if my_label == ''
        my_label += localize_year_range_label(self.jalali_year_range)
      else
        my_label += localized_number(self.jalali_date[2]) unless self.year.blank?
      end
    end
    return my_label
  end
  
  def jalali_year_range
    possible_years = []  
    self.day = 1  
    (1..12).each do |month|
      self.month = month
      jalali_year = self.jalali_date[2]
      possible_years.push( jalali_year ) unless possible_years.include?(jalali_year)
    end
    self.day = nil
    self.month = nil
    return possible_years 
  end
  
  # a function that shows the correct date system pre and post 4.1.1925
  def persian_date_label
    my_label = ''
    
    # pick jalali or islamic based on year
    greg = self.gregorian_date
    Rails.logger.info "-----my greg date: " + greg.join(", ")
    date = Date.new(greg[2],greg[0],greg[1])
    
    if date < Date.new(1925,4,1)
      my_label = self.islamic_date_label + " " + I18n.translate(:calendar_abbreviation_islamic)
    else
      my_label = self.jalali_date_label + " " + I18n.translate(:calendar_abbreviation_persian)
    end
    
    return my_label
  end
  
  def localized_source_date 
    my_localized_date = ''
    
    # check for a sort year and no source year
    self.year = self.year
    self.month = self.month
    self.day = self.day
    
    # run the localized date routines
    unless self.year.nil? || self.year == 0
      my_localized_date = case I18n.locale
        when :fa then "#{self.persian_date_label} #{I18n.translate(:secondary_date_prefix)}#{self.gregorian_date_label}#{I18n.translate(:secondary_date_suffix)}"
        else "#{self.gregorian_date_label} #{I18n.translate(:secondary_date_prefix)}#{self.persian_date_label}#{I18n.translate(:secondary_date_suffix)}"
      end
    else 
        flash[:error] = "An invalid sort date has been detected."
    end
    return my_localized_date
  end
  
  def show_date(my_locale = I18n.locale)
    date_to_show = ''
    
    # test for a passed in locale, used by admin system for preview
    if my_locale != I18n.locale
      old_locale = I18n.locale
      I18n.locale = my_locale
    end
    
    if !self.display_date.blank?
      # there is a text override to the date that should be displayed
      date_to_show += display_date
    elsif !self.era.nil?
      # there is a shorthand editorial era
      date_to_show += self.era.title     
    elsif self.year == 2050 || self.sort_year == 2050
      # there is a nonsense date entered to indicate the lack of any date and put the item last in sorts
      date_to_show += I18n.translate(:undated) 
    elsif !self.year.blank?
      # one of the numerical date fields has been filled out, so the date set should be calculated from those
      date_to_show += self.localized_source_date
    end
   
    date_to_show = I18n.translate(:circa) + ' ' +  date_to_show if self.circa && date_to_show != ''
    
    # check for editorial
    if self.editorial_date
      date_to_show = "#{I18n.translate(:editorial_date_prefix)}#{date_to_show}#{I18n.translate(:editorial_date_suffix)}"
    end
    
    I18n.locale = old_locale unless old_locale.nil?
    
    return date_to_show
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

  def preview_path(index=1)
    return LIBRARY_PATH + PREVIEWS_DIR + preview_file_name(index) unless index.nil?
  end
  
  def preview_paths
    file_urls = Array.new
    (1..self.pages).each do |page|
      file_urls << preview_path(page)
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
    dimensions_set << localize_number(floatstrip(self.height)) unless self.height.nil? || self.height == 0
    dimensions_set << localize_number(floatstrip(self.width)) unless self.width.nil? || self.width == 0
    dimensions_set << localize_number(floatstrip(self.depth)) unless self.depth.nil? || self.depth == 0
    label = dimensions_set.join(" #{I18n.translate(:dimension_separator)} ") + ' ' + I18n.translate(:dimension_unit) unless dimensions_set.empty?
    return label
  end

  def to_label
    return truncate(self.title, :length => 60) + " (#{self.id.to_s})"
  end
  
  def credit_label
    my_label = ''
    my_label += self.owner.nil? ? I18n.translate(:n_a) : self.owner.name
    my_label += " (" + self.owner_tag + ")" unless self.owner_tag.blank?
    unless self.credit.blank?
      my_label +=  ". #{self.credit}" 
    else
      unless self.owner.nil? || self.owner.credit.blank? 
        my_label += ". #{self.owner.credit}"
      end
    end  
    return my_label  
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
        self.sort_month = my_sort_date[0] unless self.month.blank?
        self.sort_day = my_sort_date[1] unless self.day.blank?
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
