class AddItemCountToCollections < ActiveRecord::Migration
  def self.up
    add_column :collections, :items_count, :integer, :null => false, :default => 0

  end

  def self.down
    remove_column :collections, :items_count
  end
end
