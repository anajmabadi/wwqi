class Passport < ActiveRecord::Base
  belongs_to :item
  belongs_to :repository

  def full_url
    #TODO: find right link formula for VIA
    return self.repository.url + self.tag unless self.repository.nil? || self.repository.url.blank?
  end
end
