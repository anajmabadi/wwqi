class AddPersonIdToAppellations < ActiveRecord::Migration
  def self.up
    add_column :appellations, :person_id, :integer, :null => false
    add_column :appellations, :position, :integer, :null => false, :default => 1
    add_index :appellations, ["person_id"], :name => 'fk_appellations_people'
    add_index :appellations, :position
  end

  def self.down
    remove_column :appellations, :person_id
    remove_column :appellations, :position
  end
end
