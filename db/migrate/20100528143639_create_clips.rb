class CreateClips < ActiveRecord::Migration
  def self.up
    create_table :clips do |t|
      t.integer :item_id, :null => false
      t.integer :clip_type_id, :null => false
      t.boolean :publish, :default => 1, :null => false
      t.text :notes
      t.date :recorded_on
      t.integer :position, :default => 0, :null => false

      t.timestamps
    end

    Clip.create_translation_table! :title => :string, :caption => :text

    add_index :clips, :item_id
    add_index :clips, :publish
    add_index :clips, :clip_type_id
    add_index :clips, :position
  end

  def self.down
    remove_index :clips, :item_id
    remove_index :clips, :publish
    remove_index :clips, :clip_type_id
    remove_index :clips, :position
    Clip.drop_translation_table!
    drop_table :clips
  end
end
