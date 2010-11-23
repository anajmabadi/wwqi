class AddEditorialDatingToItem < ActiveRecord::Migration
  def self.up
    add_column :items, :editorial_dating, :boolean, :default => false
    add_index :items, :editorial_dating
  end

  def self.down
    remove_index :items, :editorial_dating
    remove_column :items, :editorial_dating
  end
end
