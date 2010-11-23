class Era < ActiveRecord::Base

    has_many :items

    translates :title
    globalize_accessors :en, :fa
    default_scope :include => [:translations]
    def self.select_list
        return self.all(:conditions => ['era_translations.locale = ?', I18n.locale.to_s], :select => 'DISTINCT id, era_translations.title, eras.year', :order => 'eras.year').map {|era| [era.title + " (#{era.year.to_s})", era.id]}
    end

end
