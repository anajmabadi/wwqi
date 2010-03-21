class CreateAppellations < ActiveRecord::Migration
  def self.up
    create_table :appellations do |t|
      t.text :notes
      t.boolean :publish

      t.timestamps
    end
    Appellation.create_translation_table! :name => :string, :sort_name => :string
  end

  def self.down
    drop_table :appellations
    Appellation.drop_translation_table! 
  end
end
