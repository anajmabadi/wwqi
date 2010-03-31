class Period < ActiveRecord::Base
  translates :title, :caption, :description
  default_scope :include => :translations

  def tag_line
    value = title
    value += ' (' + start_year.to_s + '-' + end_year.to_s + ')'
    return value
  end
end
