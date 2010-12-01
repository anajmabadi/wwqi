class RemoveLengthFromItems < ActiveRecord::Migration
  def self.up
    remove_column :items, :length
  end

  def self.down
    add_column :items, :length, :integer
  end
end
