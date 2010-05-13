class Image < ActiveRecord::Base
  belongs_to :item
  translates :title, :description

  def tag_line
    tag = ''
    tag += title.nil? ? item.title : title
  end
end
