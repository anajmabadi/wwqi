class AddFindingAidToCollections < ActiveRecord::Migration
  def self.up
    add_column :collections, :finding_aid, :boolean, :default => 0, :null => false
    remove_column :collection_translations, :finding_aid
  end

  def self.down
    remove_column :collections, :finding_aid
    add_column :collection_translations, :finding_aid, :boolean
  end
end
