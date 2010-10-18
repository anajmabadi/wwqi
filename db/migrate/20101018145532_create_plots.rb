class CreatePlots < ActiveRecord::Migration
  def self.up
    create_table :plots do |t|
      t.integer :item_id
      t.integer :place_id
      t.text :notes
      t.boolean :publish
      t.integer :position

      t.timestamps
    end
    add_index :plots, ["place_id"], :name => 'fk_plots_places'
    add_index :plots, ["item_id"], :name => 'fk_plots_items'
    add_index :plots, :publish
    add_index :plots, :position
  end

  def self.down
    drop_table :plots
  end
end
