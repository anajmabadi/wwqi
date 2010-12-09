class CreateSections < ActiveRecord::Migration
  def self.up
    create_table :sections do |t|
      t.integer :item_id, :null => false
      t.integer :start_page, :null => false
      t.integer :end_page, :null => false
      t.integer :parent_id
      t.boolean :publish, :default => true, :null => false
      t.string :notes

      t.timestamps
    end
    
    Section.create_translation_table! :title => :string, :caption => :text, :start_page_label => :string, :end_page_label => :string
    
    add_index :sections, [:item_id], :name => "fk_sections_items"
    add_index :sections, :start_page
    add_index :sections, :end_page
    add_index :sections, :parent_id
    add_index :sections, :publish
    add_index :section_translations, :title
  end

  def self.down
    remove_index :sections, [:item_id], :name => "fk_sections_items"
    remove_index :sections, :start_page
    remove_index :sections, :end_page
    remove_index :sections, :parent_id
    remove_index :sections, :publish
    remove_index :section_translations, :title
    Section.drop_translation_table!
    drop_table :sections
  end
end
