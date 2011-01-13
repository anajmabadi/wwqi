class RemoveOwnerTagColumnFromItems < ActiveRecord::Migration
  def self.up
    remove_column :items, :owner_tag
  end

  def self.down
    add_column :items, :owner_tag, :string
  end
end
