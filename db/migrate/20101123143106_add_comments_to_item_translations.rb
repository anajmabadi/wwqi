class AddCommentsToItemTranslations < ActiveRecord::Migration
  def self.up
    add_column :item_translations, :remarks, :text
  end

  def self.down
    remove_column :item_translations, :remarks
  end
end
