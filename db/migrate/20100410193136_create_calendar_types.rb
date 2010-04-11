class CreateCalendarTypes < ActiveRecord::Migration
  def self.up
    create_table :calendar_types do |t|
      t.string :name
      t.boolean :publish
      t.text :notes

      t.timestamps
    end
  end

  def self.down
    drop_table :calendar_types
  end
end
