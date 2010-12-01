class CreateEras < ActiveRecord::Migration
  def self.up
    create_table :eras do |t|
      t.string :title
      t.integer :year
      t.boolean :publish

      t.timestamps
    end
  end

  def self.down
    drop_table :eras
  end
end
