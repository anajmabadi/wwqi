class RemoveLegacyFieldsFromItems < ActiveRecord::Migration
  def self.up
    remove_column :items, :creator_id
    remove_column :items, :dimensions
    remove_column :items, :place_id
  end

  def self.down
    add_column :items, :creator_id, :integer
    add_column :items, :dimensions, :string
    add_column :items, :place_id, :integer
  end
end
