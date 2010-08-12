class AddItemsCountToPlaces < ActiveRecord::Migration
  def self.up
    add_column :places, :items_count, :integer, :default => 0, :null => false
    Place.reset_column_information
    Place.find(:all).each do |p|
      p.update_attribute :items_count, p.items.length
      p.save
    end
  end

  def self.down
    remove_column :places, :items_count
  end
end
