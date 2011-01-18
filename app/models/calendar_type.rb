class CalendarType < ActiveRecord::Base
  has_many :items, :dependent => :restrict
  has_many :months, :dependent => :destroy, :order => :position

  validates :name, :presence => true, :uniqueness => true
  validates :publish, :inclusion => { :in => [true,false] }

  def self.select_list
    return self.all(:select => 'DISTINCT id, name', :order => 'name').map {|calendar_type| [calendar_type.name, calendar_type.id]}
  end
end
