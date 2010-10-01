class AddLockVersionToItemsImagesPeopleCollections < ActiveRecord::Migration
  def self.up
    add_column :items, :lock_version, :integer, :null => false, :default => 0
    add_column :images, :lock_version, :integer, :null => false, :default => 0
    add_column :people, :lock_version, :integer, :null => false, :default => 0
    add_column :collections, :lock_version, :integer, :null => false, :default => 0
    add_column :subjects, :lock_version, :integer, :null => false, :default => 0
    add_column :subject_types, :lock_version, :integer, :null => false, :default => 0
    add_column :appearances, :lock_version, :integer, :null => false, :default => 0
    add_column :appellations, :lock_version, :integer, :null => false, :default => 0
    add_column :calendar_types, :lock_version, :integer, :null => false, :default => 0
    add_column :categorizations, :lock_version, :integer, :null => false, :default => 0
    add_column :categories, :lock_version, :integer, :null => false, :default => 0
    add_column :classifications, :lock_version, :integer, :null => false, :default => 0
    add_column :clips, :lock_version, :integer, :null => false, :default => 0
    add_column :clip_types, :lock_version, :integer, :null => false, :default => 0
    add_column :exhibitions, :lock_version, :integer, :null => false, :default => 0
    add_column :owners, :lock_version, :integer, :null => false, :default => 0
    add_column :pages, :lock_version, :integer, :null => false, :default => 0
    add_column :panels, :lock_version, :integer, :null => false, :default => 0
    add_column :passports, :lock_version, :integer, :null => false, :default => 0
    add_column :periods, :lock_version, :integer, :null => false, :default => 0
    add_column :places, :lock_version, :integer, :null => false, :default => 0
    add_column :relationships, :lock_version, :integer, :null => false, :default => 0
    add_column :repositories, :lock_version, :integer, :null => false, :default => 0
    add_column :translations, :lock_version, :integer, :null => false, :default => 0
  end

  def self.down
    remove_column :items, :lock_version
    remove_column :images, :lock_version
    remove_column :people, :lock_version
    remove_column :collections, :lock_version
    remove_column :subjects, :lock_version
    remove_column :subject_types, :lock_version
    remove_column :appearances, :lock_version
    remove_column :appellations, :lock_version
    remove_column :calendar_types, :lock_version
    remove_column :categorizations, :lock_version
    remove_column :categories, :lock_version
    remove_column :classifications, :lock_version
    remove_column :clips, :lock_version
    remove_column :clip_types, :lock_version
    remove_column :exhibitions, :lock_version
    remove_column :owners, :lock_version
    remove_column :pages, :lock_version
    remove_column :panels, :lock_version
    remove_column :passports, :lock_version
    remove_column :periods, :lock_version
    remove_column :category, :lock_version
    remove_column :places, :lock_version
    remove_column :relationships, :lock_version
    remove_column :repositories, :lock_version
    remove_column :translations, :lock_version
  end
end
