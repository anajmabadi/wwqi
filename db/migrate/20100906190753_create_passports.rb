class CreatePassports < ActiveRecord::Migration
  def self.up
    create_table :passports do |t|
      t.string :tag
      t.integer :owner_id
      t.integer :item_id
      t.boolean :publish
      t.boolean :primary
      t.integer :position
      t.text :notes
      t.string :custom_url

      t.timestamps
    end
  end

  def self.down
    drop_table :passports
  end
end
