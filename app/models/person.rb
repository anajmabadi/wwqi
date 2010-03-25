class Person < ActiveRecord::Base

  extend ActiveModel::Translation

  translates :name, :sort_name, :description, :vitals, :birth_place
end
