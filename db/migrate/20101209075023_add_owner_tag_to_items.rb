class AddOwnerTagToItems < ActiveRecord::Migration
  def self.up
    add_column :items, :owner_tag, :string
    add_index :items, :owner_tag
  end

  def self.down
    remove_index :items, :owner_tag
    remove_column :items, :owner_tag
  end
end
