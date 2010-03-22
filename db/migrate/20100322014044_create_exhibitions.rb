class CreateExhibitions < ActiveRecord::Migration
  def self.up
    create_table :exhibitions do |t|
      
      t.date :date
      t.boolean :featured
      t.boolean :publish
      t.text :notes

      t.timestamps
    end
    Exhibition.create_translation_table! :title => :string, :caption => :string, :introduction => :text, :conclusion => :text, :author => :string
  end

  def self.down
    drop_table :exhibitions
    Exhibition.drop_translation_table!
  end
end
