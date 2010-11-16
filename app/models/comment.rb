class Comment < ActiveRecord::Base
  validates :name, :presence => true, :length => {:maximum => 255}
  validates :email, :presence => true, :length => {:maximum => 255}
  validates :body, :presence => true, :length => {:maximum => 2000}
end
