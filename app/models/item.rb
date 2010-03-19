class Item < ActiveRecord::Base
  translates :title, :caption, :description, :display_date
end
