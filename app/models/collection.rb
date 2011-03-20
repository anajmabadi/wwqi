require 'farsifu'

class Collection < ActiveRecord::Base
  has_many :items, :dependent => :restrict
  has_many :owners, :through => :items, :uniq => true
  has_many :people, :dependent => :restrict

  # globalize2 accessors including extensions
  translates :name, :caption, :sort_name, :description, :dates, :materials, :repository, :tips, :creator, :history, :restrictions, :acquisition_notes
  globalize_accessors :fa, :en
  default_scope :include => :translations
  
  validates :name_en, :presence => true, :length => {:maximum => 255}
  validates :sort_name_en, :presence => true, :length => {:maximum => 255}
  validates :name_fa, :presence => true, :length => {:maximum => 255}
  validates :sort_name_fa, :presence => true, :length => {:maximum => 255}
  validates :publish, :inclusion => { :in => [true,false] }
  validates :private, :inclusion => { :in => [true,false] }
  validates :finding_aid, :inclusion => { :in => [true,false] }
  
  def csv_fields
    return %w[	id name_fa name_en sort_name_fa sort_name_en caption_fa caption_en
    			creator_fa creator_en restrictions_fa restrictions_en history_fa history_en
    			tips_fa tips_en materials_fa materials_en dates_fa dates_en repository_fa repository_en
    			acquisition_notes_fa acquisition_notes_en acquired_by processed_by acquired_on major
    			publish finding_aid private last_edited notes]  
  end

  def self.select_list
    return self.all(:conditions => ['collection_translations.locale = ?', I18n.locale.to_s], :select => 'DISTINCT id, collection_translations.name', :order => 'collection_translations.name').map {|collection| [collection.name, collection.id]}
  end
  
  def self.random
    if (c = count(:conditions => "publish = 1 AND collection_translations.locale = '#{I18n.locale}'")) != 0
      find(:first, :conditions => "publish = 1 AND collection_translations.locale = '#{I18n.locale}'", :offset =>rand(c))
    end
  end
  
  def self.random_set(limit=3)
    collection_set = []
    until collection_set.size == limit do
      collection = self.random
      collection_set << collection unless collection_set.include?(collection) || collection.items.empty?
    end
    return collection_set
  end  
  
  def genres
  	my_genres = []
  	my_items = self.items.is_published
  	my_items.each do |item|
  		subjects = item.subjects.genres
  		my_genres = my_genres | subjects.is_published unless subjects.nil? || subjects.empty?
  	end 
  	return my_genres
  end

  # Library media file accessors
  def thumbnail_file_name
    return COLLECTION_PREFIX + id.to_s + ".jpg"
  end
  
  def thumbnail_url
    return LIBRARY_URL + COLLECTION_THUMBNAILS_DIR + thumbnail_file_name
  end
  	
  def related_item_ids_cache
  	return self.item_ids_cache.split(",").map { |i| i.to_i }.sort unless self.item_ids_cache.nil?
  end
  
  def items_count(item_ids=nil)
    begin
    # cache the values
	      if self.items_count_cache.nil? || self.item_ids_cache.nil?
	        self.item_ids_cache = self.items.is_published.select('items.id').order('items.id').all.map { |i| i.id }.join(",")
	      self.items_count_cache = self.related_item_ids_cache.size
	      end
	      count = item_ids.nil? ? self.items_count_cache : (self.related_item_ids_cache & item_ids).size
    rescue => error
	    count = 0
    end
    return count
  end
  
  def item_count_string
    if I18n.locale == :fa
      self.items(true).size.to_farsi
    else
      self.items(true).size.to_s
    end
  end
  
  def last_update
    Item.maximum(:created_at, :conditions => "collection_id = #{self.id} AND items.publish = 1 AND item_translations.locale = '#{I18n.locale}'")
  end

  def tag_line
    value = name
    value += ' (' + self.item_count_string + ')' unless self.items(true).size == 0
    return value
  end

  def finding_aid_url
    return LIBRARY_URL + FINDING_AID_DIR + finding_aid_file_name
  end

  # Library media file accessors
  def finding_aid_file_name
    return COLLECTION_PREFIX + self.id.to_s + ".pdf"
  end

  def to_label
    return "#{self.name_en.nil? ? 'N/A' : self.name_en} (#{self.id.to_s})" 
  end
end
