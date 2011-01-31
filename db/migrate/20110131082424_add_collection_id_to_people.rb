class AddCollectionIdToPeople < ActiveRecord::Migration
  def self.up
    add_column :people, :collection_id, :integer
    add_index :people, :collection_id
  end

  def self.down
    remove_index :people, :collection_id
    remove_column :people, :collection_id
  end
end
