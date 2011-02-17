class Person < ActiveRecord::Base

  include ApplicationHelper 
  	
  extend ActiveModel::Translation

  has_many :appearances, :dependent => :destroy
  has_many :items, :through => :appearances
  has_many :appellations, :dependent => :destroy
  has_many :relationships, :dependent => :destroy
  
  belongs_to :collection

  translates :name, :sort_name, :description, :vitals, :birth_place
  globalize_accessors :fa, :en
  default_scope :include => :translations

  validates :name_en, :name_fa, :sort_name_en, :sort_name_fa, :loc_name, :presence => true, :length => {:maximum => 255}
  validates :publish, :major, :inclusion => { :in => [true,false] }

  def self.select_list
    return self.select('DISTINCT id, person_translations.name, collection_translations.name').includes('collection').order('person_translations.sort_name').map {|person| [person.to_label, person.id]}.sort
  end

  def self.select_list_fa
    return self.select('DISTINCT id, person_translations.name, collection_translations.name').includes('collection').order('person_translations.sort_name').map {|person| [person.to_label_fa, person.id]}.sort
  end

  def tag_line
    value = name unless name.blank?
    value += ' (' + vitals + ')' unless vitals.blank?
    return value
  end
  
  def index_label
  	value = ""
    value += self.name unless self.name.blank?
    
    value += " <span>(#{localized_number(self.items_count)})</span>" unless self.items_count == 0
    
    unless self.vitals.blank?
    	value += '<span class="dob">(' + self.vitals + ')</span>'
    else	
    	normalized_dob = self.dob ||= 0
    	normalized_dod = self.dod ||= 0
    	
    	unless (normalized_dob + normalized_dod == 0)
    		if normalized_dod == 0 
    			value += '<span class="dob">(' + localized_number(normalized_dob) + "-" + I18n.translate(:date_unknown) + ')</span>'
    		elsif normalized_dob == 0  
    			value += '<span class="dob">(' + I18n.translate(:date_unknown) + '-' + localized_number(normalized_dod) + ')</span>'
    		else
    			value += '<span class="dob">(' + localized_number(normalized_dob) + "-" + localized_number(normalized_dod) + ')</span>'
    		end
    	end
    end 
    return value
  end

  def included_collections
    collection_ids = self.items.map { |i| i.collection_id }.reject { |i| i.nil? }.uniq.sort
    unless collection_ids.empty?
      my_set = Collection.find(collection_ids)
    end
    return my_set ||= []
  end

  def to_label
    my_label = self.name_en.blank? ? "[#{self.name_fa}]" : self.name_en
    my_label += " | #{self.collection.name}" unless self.collection.nil?
    my_label += " #{self.id.to_s}" 
    return my_label
  end

  def to_label_fa
    my_label = self.name_fa.blank? ? "[#{self.name_en}]" : self.name_fa
    my_label += " | #{self.collection.name_fa}" unless self.collection.nil?
    my_label += " #{self.id.to_s}" 
    return my_label
  end
  
  def collection_name_en
    return self.collection.nil? ? '' : self.collection.name_en
  end

  def collections_label_en
    return self.included_collections.nil? ? I18n.translate(:n_a) : self.included_collections.map { |c| c.name_en }.join(", ")
  end

  def collections_label_fa
    return self.included_collections.nil? ? I18n.translate(:n_a, :locale => :fa) : self.included_collections.map { |c| c.name_fa }.join(", ")
  end

  def items_count(item_ids=nil)
  	begin
    	count = item_ids.nil? ? self.items.is_published.count : count = self.items.is_published.where("items.id IN (?)", item_ids).count
   	rescue => error
   		count = 0
   	end
   	return count
  end

end
