class Item < ActiveRecord::Base
  translates :title, :caption, :description, :display_date
  validates uniqueness_of :olivia_id, :accession_num
end
