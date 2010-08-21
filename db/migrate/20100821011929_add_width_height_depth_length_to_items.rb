class AddWidthHeightDepthLengthToItems < ActiveRecord::Migration
  def self.up
    add_column :items, :width, :decimal, :precision => 10, :scale => 1, :default => 0, :null => false
    add_column :items, :height, :decimal, :precision => 10, :scale => 1, :default => 0, :null => false
    add_column :items, :depth, :decimal, :precision => 10, :scale => 1, :default => 0, :null => false
    add_column :items, :length, :decimal, :precision => 10, :scale => 1, :default => 0, :null => false
  end

  def self.down
    remove_column :items, :width
    remove_column :items, :height
    remove_column :items, :depth
    remove_column :items, :length
  end
end
