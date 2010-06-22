class Period < ActiveRecord::Base
  has_many :items
  translates :title, :caption, :description
  default_scope :include => :translations

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
end
