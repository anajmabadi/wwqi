class AddPublishSortNameToCollections < ActiveRecord::Migration
  def self.up
    add_column :collections, :publish, :boolean, :default => true
    add_column :collection_translations, :sort_name, :string
    add_index :collection_translations, :sort_name
    add_index :collection_translations, :name
    add_index :collections, :publish
  end

  def self.down
    remove_index :collections, :publish
    remove_index :collection_translations, :sort_name
    remove_index :collection_translations, :name
    remove_column :collection_translations, :sort_name
    remove_column :collections, :publish
  end
end
