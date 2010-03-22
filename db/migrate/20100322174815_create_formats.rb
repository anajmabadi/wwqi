class CreateFormats < ActiveRecord::Migration
  def self.up
    create_table :formats do |t|
      t.string :name
      t.string :extension
      t.boolean :publish
      t.text :notes

      t.timestamps
    end
  end

  def self.down
    drop_table :formats
  end
end
