class CreateComps < ActiveRecord::Migration
  def self.up
    create_table :comps do |t|
      t.integer :item_id, :null => false
      t.integer :comp_id, :null => false
      t.integer :position, :default => 1, :null => false
      t.boolean :publish, :default => true, :null => false
      t.string :notes

      t.timestamps
    end
    add_index :comps, :publish
    add_index :comps, :item_id
    add_index :comps, :comp_id
    add_index :comps, :position
    add_index :comps, [:item_id, :comp_id], :unique => true
  end

  def self.down
    remove_index :comps, :publish
    remove_index :comps, :item_id
    remove_index :comps, :comp_id
    remove_index :comps, :position
    remove_index :comps, [:item_id, :comp_id]
    drop_table :comps
  end
end
