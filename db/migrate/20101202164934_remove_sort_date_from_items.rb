class RemoveSortDateFromItems < ActiveRecord::Migration
  def self.up
    remove_column :items, :sort_date
  end

  def self.down
    add_column :items, :sort_date, :date
  end
end
