class SubjectType < ActiveRecord::Base
  has_many :subjects
    
  # globalize2 mixins
  translates :name, :description
  default_scope :include => :translations

end
