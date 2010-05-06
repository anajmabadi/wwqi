class Image < ActiveRecord::Base
  belongs_to :item
  translates :title, :description
end
