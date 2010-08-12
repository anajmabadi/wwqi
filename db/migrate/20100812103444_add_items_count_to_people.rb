class AddItemsCountToPeople < ActiveRecord::Migration
  def self.up
    add_column :people, :items_count, :integer, :default => 0, :null => false
    Person.reset_column_information
    Person.find(:all).each do |p|
      p.update_attribute :items_count, p.items.length
      p.save
    end
  end

  def self.down
    remove_column :people, :items_count
  end
end
