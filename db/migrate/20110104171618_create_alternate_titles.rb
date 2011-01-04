class CreateAlternateTitles < ActiveRecord::Migration
  def self.up
    create_table :alternate_titles do |t|
      t.integer :item_id, :null => :false, :default => 0
      t.boolean :publish, :null => :false, :publish => true
      t.string :notes

      t.timestamps
    end
    
    AlternateTitle.create_translation_table! :title => :string, :caption => :string
    
    add_index :alternate_titles, :item_id
    add_index :alternate_titles, :publish
    add_index :alternate_title_translations, :title
    add_index :alternate_title_translations, :caption
  end

  def self.down
    remove_index :alternate_titles, :item_id
    remove_index :alternate_titles, :publish
    remove_index :alternate_title_translations, :title
    remove_index :alternate_title_translations, :caption
    AlternateTitle.drop_translation_table!
    drop_table :alternate_titles
  end
end
