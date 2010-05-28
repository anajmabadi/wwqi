class CreateClipTypes < ActiveRecord::Migration
  def self.up
    create_table :clip_types do |t|
      t.string :name
      t.string :extension
      t.boolean :publish
      t.text :notes

      t.timestamps
    end
    add_index :clip_types, :publish
  end

  def self.down
    remove_index :clip_types, :publish
    drop_table :clip_types
  end
end
