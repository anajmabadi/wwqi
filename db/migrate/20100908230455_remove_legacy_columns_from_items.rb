class RemoveLegacyColumnsFromItems < ActiveRecord::Migration
  def self.up
    remove_column :items, :olivia_id
    remove_column :items, :period_id
    remove_column :items, :category_id

    # add one we need
    add_column :item_translations, :publisher, :string
  end

  def self.down
    add_column :items, :olivia_id, :integer
    add_column :items, :period_id, :integer
    add_column :items, :category_id, :integer

    remove_column :item_translations, :publisher, :string
  end
end
