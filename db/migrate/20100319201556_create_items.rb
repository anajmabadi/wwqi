class CreateItems < ActiveRecord::Migration
  def self.up
    create_table :items do |t|
      t.string :accession_num
      t.string :olivia_id
      t.string :urn
      t.integer :creator_id
      t.integer :owner_id
      t.integer :collection_id
      t.integer :pages
      t.integer :format_id
      t.date :sort_date
      t.string :dimensions
      t.text :notes
      t.integer :place_id
      t.boolean :publish
      t.timestamps
    end
    Item.create_translation_table! :title => :string, :caption => :string, :description => :text, :display_date => :string
  end

  def self.down
    drop_table :items
    Item.drop_translation_table!
  end
end
