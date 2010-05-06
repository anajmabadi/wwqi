class CreateImages < ActiveRecord::Migration
  def self.up
    create_table :images do |t|
      t.integer :item_id
      t.string :dimensions
      t.boolean :verso
      t.integer :position
      t.text :notes
      t.boolean :publish

      t.timestamps
    end
    Image.create_translation_table! :title => :string, :description => :text
    add_index :images, :item_id
    add_index :images, :publish
    add_index :images, :position
  end

  def self.down
    remove_index :images, :item_id
    remove_index :images, :publish
    remove_index :images, :position
    drop_table :images
    Image.drop_translation_table!
  end
end
