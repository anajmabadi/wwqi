class Person < ActiveRecord::Base
  translates :name, :description, :vitals, :birth_place
end
