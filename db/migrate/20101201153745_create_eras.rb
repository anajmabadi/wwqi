class CreateEras < ActiveRecord::Migration
  def self.up
    create_table :eras do |t|
      t.integer :year
      t.boolean :publish

      t.timestamps
    end
    Era.create_translation_table! :title => :string
  end

  def self.down
    Era.drop_translation_table! 
    drop_table :eras
  end
end
