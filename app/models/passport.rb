class Passport < ActiveRecord::Base
  belongs_to :item
  belongs_to :repository

  validates :tag, :presence => true, :length => { :maximum => 255 }
  validates :publish, :presence => true
  validates :primary, :presence => true
  validates :repository, :presence => true, :numericality => true
  validates :custom_url, :length => { :maximum => 255 }
  validates :position, :presence => true, :numericality => { :greater_than_or_equal_to => 0, :less_than => 10001 }

  def full_url
    #TODO: find right link formula for VIA
    my_url = ''
    unless self.custom_url.blank?
      my_url += self.custom_url
    else
      my_url += self.repository.url unless self.repository.nil? || self.repository.url.blank?
    end
    my_url += self.tag unless self.tag.blank?
    return my_url
  end
end
