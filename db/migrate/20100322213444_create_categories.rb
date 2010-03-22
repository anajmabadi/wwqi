class CreateCategories < ActiveRecord::Migration
  def self.up
    create_table :categories do |t|

      t.integer :position
      t.boolean :publish
      t.text :notes

      t.timestamps
    end
    add_index :categories, :position
    add_index :categories, :publish
    Category.create_translation_table! :name => :string, :description => :text
  end

  def self.down
    drop_table :categories
    Category.drop_translation_table! 
  end
end
