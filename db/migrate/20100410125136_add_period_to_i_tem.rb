class AddPeriodToITem < ActiveRecord::Migration
  def self.up
    add_column :items, :period_id, :integer
    add_index :items, :period_id
  end

  def self.down
    remove_index :items, :period_id
    remove_column :items, :periuod_id, :integer
  end
end
