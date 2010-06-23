class SubjectType < ActiveRecord::Base
  translates :name, :description

  has_many :subjects
end
