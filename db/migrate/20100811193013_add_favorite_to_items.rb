class AddFavoriteToItems < ActiveRecord::Migration
  def self.up
    add_column :items, :favorite, :boolean
    add_index :items, :favorite
  end

  def self.down
    remove_index :items, :favorite
    remove_column :items, :favorite
  end
end
