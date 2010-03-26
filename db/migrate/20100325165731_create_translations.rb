class CreateTranslations < ActiveRecord::Migration
  def self.up
    create_table :translations do |t|
      t.string :locale
      t.string :key
      t.text :value
      t.text :interpolations
      t.boolean :is_proc, :default => false

      t.timestamps
    end
    add_index :translations, :key
    add_index :translations, :locale
  end

  def self.down
    remove_index :translations, :key
    remove_index :translations, :locale
    drop_table :translations
  end
end
