class CreateClassifications < ActiveRecord::Migration
  def self.up
    create_table :classifications do |t|
      t.integer :subject_id
      t.integer :item_id
      t.boolean :publish
      t.integer :position
      t.text :notes

      t.timestamps
    end
    add_index :classifications, :subject_id
    add_index :classifications, :item_id
    add_index :classifications, [:item_id,:subject_id], :unique => true
    add_index :classifications, :publish
    add_index :classifications, :position
  end

  def self.down
    remove_index :classifications, :subject_id
    remove_index :classifications, :item_id
    remove_index :classifications, [:item_id,:subject_id]
    remove_index :classifications, :publish
    remove_index :classifications, :position
    drop_table :classifications
  end
end
