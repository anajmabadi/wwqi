class Appellation < ActiveRecord::Base
  translates :name, :sort_name
end
