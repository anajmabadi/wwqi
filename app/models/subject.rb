class Subject < ActiveRecord::Base

  belongs_to :subject_type
  
  has_many :classifications, :dependent => :destroy
  has_many :items, :through => :classifications, :order => :position

  validates :name_en, :presence => true, :length =>{:maximum => 256}
  validates :name_fa, :presence => true, :length =>{:maximum => 256}

  translates :name
  default_scope :include => :translations
  globalize_accessors :fa, :en

  # pagination code
  cattr_reader :per_page
  @@per_page = 1000

  def self.select_list
    return self.all.map {|subject| [subject.to_label, subject.id]}.sort
  end
  
  def to_label
    my_label = ''
    my_label += self.name_en unless self.name_en.blank?
    my_label += " | #{self.name_fa}" unless self.name_fa.blank?
    return my_label
  end
end
