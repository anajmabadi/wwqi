class Passport < ActiveRecord::Base
  belongs_to :item
  belongs_to :repository
end
