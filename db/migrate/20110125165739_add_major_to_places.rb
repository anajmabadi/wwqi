class AddMajorToPlaces < ActiveRecord::Migration
  def self.up
    add_column :places, :major, :boolean, :default => false, :null => :false
    add_column :collections, :major, :boolean, :default => false, :null => :false
    add_column :periods, :major, :boolean, :default => false, :null => :false
    add_index :places, :major
    add_index :collections, :major
    add_index :periods, :major
  end

  def self.down
    remove_index :places, :major
    remove_index :collections, :major
    remove_index :periods, :major 
    remove_column :places, :major
    remove_column :collections, :major
    remove_column :periods, :major 
  end
end
