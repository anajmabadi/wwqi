class CreatePeriods < ActiveRecord::Migration
  def self.up
    create_table :periods do |t|
      t.date :start_date
      t.date :end_date
      t.integer :position
      t.boolean :publish
      t.text :notes

      t.timestamps
    end
    Period.create_translation_table! :title => :string, :caption => :string, :description => :text
    add_index :periods, :publish
    add_index :periods, :start_date
    add_index :periods, :end_date
    add_index :periods, :position
  end

  def self.down
    remove_index :periods, :publish
    remove_index :periods, :start_date
    remove_index :periods, :end_date
    remove_index :periods, :position
    drop_table :periods
    Period.drop_translation_table!
  end
end
