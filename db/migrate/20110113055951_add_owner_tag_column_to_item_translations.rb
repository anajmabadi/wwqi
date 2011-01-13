class AddOwnerTagColumnToItemTranslations < ActiveRecord::Migration
  def self.up
    add_column :item_translations, :owner_tag, :string
  end

  def self.down
    remove_column :item_translations, :owner_tag
  end
end
