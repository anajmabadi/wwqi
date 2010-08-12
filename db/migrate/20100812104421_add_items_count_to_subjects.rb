class AddItemsCountToSubjects < ActiveRecord::Migration
  def self.up
    add_column :subjects, :items_count, :integer, :default => 0, :null => false
    Subject.reset_column_information
    Subject.find(:all).each do |p|
      p.update_attribute :items_count, p.items.length
      p.save
    end
  end

  def self.down
    remove_column :subjects, :items_count
  end
end
