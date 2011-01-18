class Period < ActiveRecord::Base

  translates :title, :caption, :description
  default_scope :include => :translations
  globalize_accessors :en, :fa

  def tag_line
    value = title
    value += ' (' + start_year.to_s + '-' + end_year.to_s + ' [' + j_start_year.to_s + '-' + j_end_year.to_s + ']' + ')' unless start_year.blank? || end_year.blank?
    return value
  end

  def j_start_year
    return JalaliDate.new(Date.new(start_year)).year
  end

  def j_end_year
    return JalaliDate.new(Date.new(end_year)).year
  end

  def self.select_list
    return self.all(:conditions => ['period_translations.locale = ?', I18n.locale.to_s], :select => 'DISTINCT id, period_translations.title', :order => 'periods.start_at').map {|period| [period.title, period.id]}
  end

  def to_label
    return self.title
  end
  
  def items
    return Item.where("sort_year BETWEEN '#{self.start_at.strftime("%Y")}' AND '#{self.end_at.strftime("%Y")}'").all
  end
  
  def items_count
    return self.items.size
  end
  
end
