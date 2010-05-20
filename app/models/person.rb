class Person < ActiveRecord::Base

  extend ActiveModel::Translation

  has_many :appearances

  has_many :items, :through => :appearances


  translates :name, :sort_name, :description, :vitals, :birth_place
  
  default_scope :include => :translations

  def tag_line
    value = name unless name.blank?
    value += ' (' + vitals + ')' unless vitals.blank?
    return value
  end
  
end
