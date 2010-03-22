class Item < ActiveRecord::Base
  belongs_to :owner
  belongs_to :collection
  translates :title, :caption, :description, :display_date
  validates uniqueness_of :olivia_id, :accession_num
end
