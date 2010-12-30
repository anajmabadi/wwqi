class AddDimensionsFieldsToImages < ActiveRecord::Migration
  def self.up
    add_column :images, :width, :decimal, :precision => 10, :scale => 1, :default => 0, :null => false
    add_column :images, :height, :decimal, :precision => 10, :scale => 1, :default => 0, :null => false
    add_column :images, :depth, :decimal, :precision => 10, :scale => 1, :default => 0, :null => false
  end

  def self.down
    remove_column :images, :depth
    remove_column :images, :height
    remove_column :images, :width
  end
end
