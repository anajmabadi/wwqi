class ConvertDimensionsToHeightWidth < ActiveRecord::Migration
  def self.up
    @items = Item.find(:all, :conditions => 'dimensions IS NOT NULL')
    @items.each do |item|
      @dimensions = item.dimensions
      @dimensions_pieces = @dimensions.split(" ")
      item.height = @dimensions_pieces[0]
      item.width = @dimensions_pieces[2]
      item.save
    end
  end

  def self.down
  end
end
