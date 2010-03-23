class Item < ActiveRecord::Base
  belongs_to :owner
  belongs_to :collection
  belongs_to :format
  belongs_to :medium
  translates :title, :caption, :description, :display_date
  validates_uniqueness_of :olivia_id, :accession_num
end
