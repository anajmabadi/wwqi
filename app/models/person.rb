class Person < ActiveRecord::Base

  extend ActiveModel::Translation

  has_many :appearances
  has_many :items, :through => :appearances
  has_many :appellations

  translates :name, :sort_name, :description, :vitals, :birth_place
  globalize_accessors :fa, :en
  default_scope :include => :translations

  def self.select_list
    return self.all(:conditions => ['person_translations.locale = ?', I18n.locale.to_s], :select => 'DISTINCT id, person_translations.name', :order => 'person_translations.sort_name').map {|person| [person.name, person.id]}
  end

  def tag_line
    value = name unless name.blank?
    value += ' (' + vitals + ')' unless vitals.blank?
    return value
  end
  
end
