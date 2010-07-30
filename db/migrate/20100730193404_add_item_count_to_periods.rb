class AddItemCountToPeriods < ActiveRecord::Migration
  def self.up
    add_column :periods, :items_count, :integer, :default => 0
    Period.reset_column_information
    Period.find(:all).each do |p|
      p.update_attribute :items_count, p.items.length
    end
  end

  def self.down
    remove_column :periods, :items_count
  end
end
