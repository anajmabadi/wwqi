class CreateSections < ActiveRecord::Migration
  def self.up
    create_table :sections do |t|
      t.string :title
      t.text :caption
      t.integer :start_page
      t.string :start_page_label
      t.integer :end_page
      t.string :end_page_label
      t.integer :parent_id
      t.boolean :publish
      t.string :notes

      t.timestamps
    end
  end

  def self.down
    drop_table :sections
  end
end
