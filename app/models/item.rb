class Item < ActiveRecord::Base
  belongs_to :owner
  belongs_to :collection
  belongs_to :format
  belongs_to :medium
  belongs_to :place
  belongs_to :period
  belongs_to :category
  belongs_to :calendar_type
  translates :title, :caption, :description, :display_date
  

  validates_uniqueness_of :olivia_id, :accession_num

  default_scope :include => :translations

  def show_date
    unless display_date.blank?
      return display_date
    else
      return sort_date.to_s
    end
  end
end
