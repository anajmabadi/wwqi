class AddItemsCountToSubjectsAgain < ActiveRecord::Migration
  def self.up
    add_column :subjects, :items_count_cache, :integer,:null => false, :default => 0
    add_column :subjects, :item_ids_cache, :string,:null => false, :default => ""
    add_index :subjects, :items_count_cache
  end

  def self.down
  	remove_index :subjects, :items_count_cache
    remove_column :subjects, :items_count_cache
    remove_column :subjects, :item_ids_cache
  end
end
