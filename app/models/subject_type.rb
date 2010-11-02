class SubjectType < ActiveRecord::Base
  has_many :subjects
  has_many :classifications, :through => :subjects, :source => :classifications, :uniq => true
    
  # globalize2 mixins
  translates :name, :description
  default_scope :include => :translations
  globalize_accessors :fa, :en
  
  def show_menu?
    return self.subjects.size > 2
  end

  def self.select_list
    return self.all(:conditions => ['subject_type_translations.locale = ?', I18n.locale.to_s],:select => 'DISTINCT id, subject_type_translations.name', :order => 'subject_type_translations.name').map {|subject_type| [subject_type.name, subject_type.id]}
  end

  def to_label
    return name
  end
end
