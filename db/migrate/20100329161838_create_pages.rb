class CreatePages < ActiveRecord::Migration
  def self.up
    create_table :pages do |t|
      t.boolean :publish
      t.text :notes

      t.timestamps
    end
    Page.create_translation_table! :title => :string, :author => :string, :caption => :text, :body => :text
    add_index :page_translations, :title
    add_index :pages, :publish
  end

  def self.down
    remove_index :page_translations, :title
    remove_index :pages, :publish
    drop_table :pages
    Page.drop_translation_table! 
  end
end
