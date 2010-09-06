class CreateRepositories < ActiveRecord::Migration
  def self.up
    create_table :repositories do |t|
      t.integer :owner_id, :null => false
      t.string :url, :null => false
      t.boolean :publish, :default => true, :null => false
      t.text :notes

      t.timestamps
    end
    Repository.create_translation_table! :name => :string
    add_index :repository_translations, :name
    add_index :repositories, ["owner_id"], :name => 'fk_repositories_owners'
    add_index :repositories, :publish
  end

  def self.down
    Repository.drop_translation_table!
    remove_index :repository_translations, :name
    remove_index :repositories, ["owner_id"]
    remove_index :repositories, :publish
    drop_table :repositories
  end
end
