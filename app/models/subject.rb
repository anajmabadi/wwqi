class Subject < ActiveRecord::Base

  belongs_to :subject_type

  has_many :classifications, :dependent => :destroy
  has_many :items, :through => :classifications, :order => :position

  validates :name_en, :name_fa, :presence => true, :length =>{:maximum => 255}
  validates :subject_type_id, :presence => true, :numericality => true
  validates :publish, :inclusion => { :in => [true,false] }
  validates :major, :inclusion => { :in => [true,false] }

  
  translates :name
  default_scope :include => :translations
  globalize_accessors :fa, :en
  
  scope :genres, lambda {
    where(["subject_type_id=?", 8])
  }

  scope :concepts, lambda {
    where(["subject_type_id=?", 7])
  }
  
  # pagination code
  cattr_reader :per_page
  @@per_page = 1000
  def self.select_list
    return self.all.map {|subject| [subject.to_label, subject.id]}.sort
  end

  def self.concept_list
    return self.where(['subject_type_id=?',7]).map {|subject| [subject.to_label, subject.id]}.sort
  end
  
  def self.genre_list
    return self.where(['subject_type_id=?',8]).map {|subject| [subject.to_label, subject.id]}.sort
  end

  def to_label
    my_label = ''
    my_label += self.name_en unless self.name_en.blank?
    my_label += " | #{self.name_fa}" unless self.name_fa.blank?
    return my_label
  end
end
