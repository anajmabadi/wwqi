class Appearance < ActiveRecord::Base
  belongs_to :item
  belongs_to :person

  translates :caption
end
