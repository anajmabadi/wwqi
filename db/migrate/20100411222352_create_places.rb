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
    add_index :places, :name
    Place.create_translation_table! :name => :string
  end

  def self.down
    drop_table :places
    Place.drop_translation_table!
  end
end
