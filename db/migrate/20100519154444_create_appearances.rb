class CreateAppearances < ActiveRecord::Migration
  def self.up
    create_table :appearances do |t|
      t.integer :item_id
      t.integer :person_id
      t.boolean :publish, :default => 1
      t.integer :position, :default => 0
      t.text :notes

      t.timestamps
    end
    add_index :appearances, :item_id
    add_index :appearances, :person_id
    add_index :appearances, :publish
    add_index :appearances, :position
    Appearance.create_translation_table! :caption => :text
  end

  def self.down
    remove_index :appearances, :item_id
    remove_index :appearances, :person_id
    remove_index :appearances, :publish
#    remove_index :appearances, :position
    drop_table :appearances
    Appearance.drop_translation_table!
  end
end
