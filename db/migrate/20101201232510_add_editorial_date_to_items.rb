class AddEditorialDateToItems < ActiveRecord::Migration
  def self.up
    add_column :items, :editorial_date, :boolean, :default => false
  end

  def self.down
    remove_column :items, :editorial_date
  end
end
