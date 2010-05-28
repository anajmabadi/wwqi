class Clip < ActiveRecord::Base
  belongs_to :item
  belongs_to :clip_type

  translates :title, :caption
end
