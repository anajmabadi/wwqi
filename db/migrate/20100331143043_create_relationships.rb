class CreateRelationships < ActiveRecord::Migration
  def self.up
    create_table :relationships do |t|
      t.string :name
      t.text :description
      t.integer :position
      t.boolean :publish
      t.text :notes

      t.timestamps
    end
  end

  def self.down
    drop_table :relationships
  end
end
