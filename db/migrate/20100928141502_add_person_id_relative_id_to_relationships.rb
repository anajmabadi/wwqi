class AddPersonIdRelativeIdToRelationships < ActiveRecord::Migration
  def self.up
    remove_column :relationships, :name
    remove_column :relationships, :description

    add_column :relationships, :person_id, :integer
    add_column :relationships, :relative_id, :integer
    add_index :appellations, ["person_id"], :name => 'fk_relatives_people'

    Relationship.create_translation_table! :name => :string, :description => :text
  end

  def self.down
    add_column :relationships, :name, :string
    add_column :relationships, :description, :text

    Relationship.drop_translation_table!
    
    remove_column :relationships, :relative_id
    remove_column :relationships, :person_id
  end
end
