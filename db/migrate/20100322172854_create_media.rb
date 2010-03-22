class CreateMedia < ActiveRecord::Migration
  def self.up
    create_table :media do |t|

      t.integer :position
      t.boolean :publish
      t.text :notes

      t.timestamps
    end
    Medium.create_translation_table! :name => :string, :description => :text
    add_index :media, :position
    add_index :media, :publish
  end

  def self.down
    remove_index :media, :publish
    remove_index :media, :position
    drop_table :media
    Medium.drop_translation_table!
  end
end
