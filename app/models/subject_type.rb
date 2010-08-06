class SubjectType < ActiveRecord::Base
  has_many :subjects
    
  # globalize2 mixins
  translates :name, :description
  default_scope :include => :translations
  globalize_accessors :fa, :en
  
  def show_menu?
    return self.subjects.size > 2
  end

end
