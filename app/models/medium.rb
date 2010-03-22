class Medium < ActiveRecord::Base
  translates :name, :description
  has_many :items
end
