class CreatePlaces < ActiveRecord::Migration
  def self.up
    create_table :places do |t|
      t.string :latitude
      t.string :longitude
      t.integer :x
      t.integer :y
      t.boolean :publish
      t.text :notes

      t.timestamps
    end
    add_index :places, :publish
    Place.create_translation_table! :name => :string
    add_index :place_translations, :name
  end

  def self.down
    remove_index :places, :publish
    drop_table :places
    remove_index :place_translations, :name
    Place.drop_translation_table!

  end
end
