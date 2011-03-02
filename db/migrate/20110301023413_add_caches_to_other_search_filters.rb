class AddCachesToOtherSearchFilters < ActiveRecord::Migration
  def self.up
    add_column :places, :items_count_cache, :integer,:null => false, :default => 0
    add_column :places, :item_ids_cache, :string,:null => false, :default => ""
    add_index :places, :items_count_cache
    add_column :people, :items_count_cache, :integer,:null => false, :default => 0
    add_column :people, :item_ids_cache, :string,:null => false, :default => ""
    add_index :people, :items_count_cache
    add_column :periods, :items_count_cache, :integer,:null => false, :default => 0
    add_column :periods, :item_ids_cache, :string,:null => false, :default => ""
    add_index :periods, :items_count_cache
    add_column :collections, :items_count_cache, :integer,:null => false, :default => 0
    add_column :collections, :item_ids_cache, :string,:null => false, :default => ""
    add_index :collections, :items_count_cache
  end

  def self.down
    remove_index :places, :items_count_cache
    remove_column :places, :items_count_cache
    remove_column :places, :item_ids_cache
    
    remove_index :people, :items_count_cache
    remove_column :people, :items_count_cache
    remove_column :people, :item_ids_cache
 
    remove_index :periods, :items_count_cache
    remove_column :periods, :items_count_cache
    remove_column :periods, :item_ids_cache
  
    remove_index :collections, :items_count_cache
    remove_column :collections, :items_count_cache
    remove_column :collections, :item_ids_cache
  end
end
