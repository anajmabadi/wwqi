class CreatePanels < ActiveRecord::Migration
  def self.up
    create_table :panels do |t|
      t.integer :exhibition_id
      t.integer :item_id
      t.integer :position
      t.boolean :publish
      t.text :caption
      t.text :notes

      t.timestamps
    end
  end

  def self.down
    drop_table :panels
  end
end
