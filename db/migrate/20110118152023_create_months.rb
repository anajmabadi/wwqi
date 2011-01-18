class CreateMonths < ActiveRecord::Migration
  def self.up
    create_table :months do |t|
      t.integer :calendar_type_id, :null => false
      t.integer :position, :null => false, :default => 1
      t.boolean :publish, :null => false, :default => true
      t.string :notes

      t.timestamps
    end
    
    Month.create_translation_table! :name => :string
    
    add_index :months, :calendar_type_id
    add_index :months, :position
    add_index :months, :publish
    add_index :month_translations, :name
    
  end

  def self.down
    remove_index :months, :calendar_type_id
    remove_index :months, :position
    remove_index :months, :publish
    remove_index :month_translations, :name
    
    Month.drop_translation_table!
    drop_table :months
  end
end
