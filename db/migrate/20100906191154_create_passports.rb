class CreatePassports < ActiveRecord::Migration
  def self.up
    create_table :passports do |t|
      t.string :tag
      t.integer :repository_id
      t.integer :item_id
      t.boolean :publish
      t.boolean :primary
      t.integer :position
      t.text :notes
      t.string :custom_url

      t.timestamps
    end

    add_index :passports, ["repository_id"], :name => "fk_passports_repositories"
    add_index :passports, ["item_id"], :name => "fk_passports_items"
    add_index :passports, :primary
    add_index :passports, :position
    add_index :passports, :publish
    add_index :passports, :tag

  end

  def self.down
    remove_index :passports, ["repository_id"]
    remove_index :passports, ["item_id"]
    remove_index :passports, :primary
    remove_index :passports, :position
    remove_index :passports, :publish
    remove_index :passports, :tag
    drop_table :passports
  end
end
