class AddLastEditedToCollections < ActiveRecord::Migration
  def self.up
    add_column :collections, :last_edited, :date
    add_index :collections, :last_edited
  end

  def self.down
    remove_index :collections, :last_edited
    remove_column :collections, :last_edited
  end
end
