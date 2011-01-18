class RemoveItemCountFields < ActiveRecord::Migration
  def self.up
    remove_column :places, :items_count
    remove_column :subjects, :items_count
    remove_column :collections, :items_count
    remove_column :people, :items_count
    remove_column :periods, :items_count
  end

  def self.down
    add_column :places, :items_count
    add_column :subjects, :items_count
    add_column :collections, :items_count
    add_column :people, :items_count
    add_column :periods, :items_count
  end
end
