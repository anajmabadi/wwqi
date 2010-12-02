class CreateEras < ActiveRecord::Migration
    def self.up
        create_table :eras do |t|
            t.integer :year
            t.boolean :publish, :default => true, :null => false

            t.timestamps
        end

        Era.create_translation_table! :title => :string

        add_index :era_translations, :title
    end

    def self.down
        remove_index :era_translations, :title
        
        Era.drop_translation_table! 
        
        drop_table :eras
    end
end
