class Image < ActiveRecord::Base
  belongs_to :item
  translates :title, :description

  def tag_line
    tag = ''
    tag += title.nil? ? item.title : title
  end
  
  def tif_file_name
    return file_prefix + item_id.to_s + "_" + position.to_s + ".tif"
  end
  
  def file_prefix
    return "it_"
  end
end
