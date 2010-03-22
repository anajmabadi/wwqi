class Category < ActiveRecord::Base
  translates :name, :description
end
