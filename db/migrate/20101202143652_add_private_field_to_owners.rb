class AddPrivateFieldToOwners < ActiveRecord::Migration
  def self.up
    add_column :owners, :private, :boolean, :default => false
  end

  def self.down
    remove_column :owners, :private
  end
end
