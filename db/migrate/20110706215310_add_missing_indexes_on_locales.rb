class AddMissingIndexesOnLocales < ActiveRecord::Migration
  def self.up
    add_index :calendar_type_translations, :locale
    add_index :item_translations, [ :locale, :published ]
    add_index :category_translations, :locale
    add_index :collection_translations, :locale
    add_index :era_translations, :locale
    add_index :exhibition_translations, :locale
    add_index :image_translations, :locale
    add_index :medium_translations, :locale
    add_index :month_translations, :locale
    add_index :page_translations, :locale
    add_index :panel_translations, :locale
    add_index :period_translations, :locale
    add_index :place_translations, :locale
    add_index :relationship_translations, :locale
    add_index :repository_translations, :locale
    add_index :section_translations, :locale
  end

  def self.down
    remove_index :section_translations, :column => :locale
    remove_index :repository_translations, :column => :locale
    remove_index :relationship_translations, :column => :locale
    remove_index :place_translations, :column => :locale
    remove_index :period_translations, :column => :locale
    remove_index :panel_translations, :column => :locale
    remove_index :page_translations, :column => :locale
    remove_index :month_translations, :column => :locale
    remove_index :medium_translations, :column => :locale
    remove_index :image_translations, :column => :locale
    remove_index :exhibition_translations, :column => :locale
    remove_index :era_translations, :column => :locale
    remove_index :collection_translations, :column => :locale
    remove_index :category_translations, :column => :locale
    remove_index :item_translations, :column => [ :locale, :published ]
    remove_index :calendar_type_translations, :column => :locale
  end
end
