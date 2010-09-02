class AddDescriptionDatesMaterialsRepositoryTipsToCollectionTranslations < ActiveRecord::Migration
  def self.up
    add_column :collection_translations, :description, :text
    add_column :collection_translations, :dates, :string
    add_column :collection_translations, :materials, :text
    add_column :collection_translations, :repository, :text
    add_column :collection_translations, :tips, :text
    add_column :collection_translations, :finding_aid, :boolean
  end

  def self.down
    remove_column :collection_translations, :finding_aid
    remove_column :collection_translations, :tips
    remove_column :collection_translations, :repository
    remove_column :collection_translations, :materials
    remove_column :collection_translations, :dates
    remove_column :collection_translations, :description
  end
end
