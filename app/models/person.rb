class Person < ActiveRecord::Base

  extend ActiveModel::Translation

  has_many :appearances
  has_many :items, :through => :appearances
  has_many :appellations
  has_many :relationships

  translates :name, :sort_name, :description, :vitals, :birth_place
  globalize_accessors :fa, :en
  default_scope :include => :translations
  def self.select_list
    return self.all(:select => 'DISTINCT id, person_translations.name', :order => 'person_translations.sort_name').map {|person| [person.to_label, person.id]}.sort
  end

  def self.select_list_fa
    return self.all(:select => 'DISTINCT id, person_translations.name', :order => 'person_translations.sort_name').map {|person| [person.to_label_fa, person.id]}.sort
  end

  def tag_line
    value = name unless name.blank?
    value += ' (' + vitals + ')' unless vitals.blank?
    return value
  end

  def collections
    return Collection.find(self.items.map { |item| item.collection_id }.uniq.sort) unless self.items.empty?
  end

  def to_label
    my_label = self.name_en.blank? ? "[#{self.name_fa}]" : self.name_en
    my_label += " | #{self.id.to_s}: #{collections_label}" 
    return my_label
  end
  
  def to_label_fa
    my_label = self.name_fa.blank? ? "[#{self.name_en}]" : self.name_fa
    my_label += " | #{self.id.to_s}: #{collections_label}" 
    return my_label
  end
  
  def collections_label
    return self.collections.nil? ? 'No Collection' : self.collections.map { |c| c.name }.join(", ") 
  end
end
