class AddNewFieldsToCollections < ActiveRecord::Migration
  def self.up
    add_column :collection_translations, :creator, :string
    add_column :collection_translations, :restrictions, :text
    add_column :collection_translations, :history, :text
    add_column :collections, :acquired_on, :date
    add_column :collections, :interview_id, :integer
    add_column :collections, :acquired_by, :string
    add_column :collections, :processed_by, :string
    add_column :collections, :acquisition_notes, :text
  end

  def self.down
    remove_column :collections, :acquisition_notes
    remove_column :collections, :processed_by
    remove_column :collections, :acquired_by
    remove_column :collections, :interview_id
    remove_column :collections, :acquired_on
    remove_column :collection_translations, :history
    remove_column :collections_translation, :restrictions
    remove_column :collections_translation, :creator
  end
end
