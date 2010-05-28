class CreatePanels < ActiveRecord::Migration
  def self.up
    create_table :panels do |t|
      t.integer :exhibition_id, :null => false
      t.integer :item_id, :null => false
      t.integer :position, :default => 0, :null => false
      t.boolean :publish, :default => true, :null => false
      t.text :notes

      t.timestamps
    end
    Panel.create_translation_table! :caption => :text
    add_index :panels, :publish
    add_index :panels, :position
    add_index :panels, :exhibition_id
    add_index :panels, :item_id
  end

  def self.down
    remove_index :panels, :publish
    remove_index :panels, :position
    remove_index :panels, :exhibition_id
    remove_index :panels, :item_id
    Panel.drop_translation_table!
    drop_table :panels
  end
end
