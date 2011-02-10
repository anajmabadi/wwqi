class Period < ActiveRecord::Base

  translates :title, :caption, :description
  default_scope :include => :translations
  globalize_accessors :en, :fa
  
  validates :start_at, :end_at, :presence => true, :numericality => true

  def tag_line
    value = title
    value += ' (' + start_at.year.to_s + '-' + end_at.year.to_s + ' [' + j_start_year.to_s + '-' + j_end_year.to_s + ']' + ')' unless start_at.blank? || end_at.blank?
    return value
  end

  def j_start_year
    return jalali_from_gregorian(start_at)[2]
  end

  def j_end_year
    return jalali_from_gregorian(end_at)[2]
  end
  
  def jalali_from_gregorian(my_date = Date.now)
  	return Calendar.jalaali_from_absolute(Calendar.absolute_from_gregorian(my_date.month, my_date.day, my_date.year))
  end

  def self.select_list
    return self.all(:conditions => ['period_translations.locale = ?', I18n.locale.to_s], :select => 'DISTINCT id, period_translations.title', :order => 'periods.start_at').map {|period| [period.title, period.id]}
  end

  def to_label
    return self.title
  end
  
  def item_query
  	Item.where(["publish = ? AND sort_year BETWEEN ? AND ?", true, self.start_at.strftime("%Y"), self.end_at.strftime("%Y")] )
  end
  
  def items
    return self.item_query.all
  end
  
  def items_count
    return self.item_query.count
  end
  
end
