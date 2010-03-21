class Person < ActiveRecord::Base
  translates :name, :sort_name, :description, :vitals, :birth_place
end
