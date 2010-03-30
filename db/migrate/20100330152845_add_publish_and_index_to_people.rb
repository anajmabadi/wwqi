class AddPublishAndIndexToPeople < ActiveRecord::Migration
  def self.up
    add_column :people, :publish, :boolean, :default => true
    add_index :people, :publish
  end

  def self.down
    remove_index :people, :publish
    remove_column :people, :publish
  end
end
