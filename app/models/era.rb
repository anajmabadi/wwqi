class Era < ActiveRecord::Base

  has_many :items

  translates :title
  globalize_accessors :en, :fa
  default_scope :include => [:translations]
  
  @@cached_select_list = []
  
  def self.select_list
    if @@cached_select_list.empty?
      @@cached_select_list = self.all(:conditions => ['era_translations.locale = ?', I18n.locale.to_s],:select => 'DISTINCT id, era_translations.title', :order => 'era_translations.title').map {|e| [e.title, e.id]}
    end
    return @@cached_select_list
  end
end
