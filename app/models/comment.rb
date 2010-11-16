class Comment < ActiveRecord::Base
  validates :name, :presence => true, :length => {:maximum => 255}
  validates :email, :presence => true, :length => {:maximum => 255}
  validates :body, :presence => true, :length => {:maximum => 2000}
  validates :math_problem, :presence => true, :numericality => {:equal_to => 2}
  
  attr_accessor :math_problem
end
