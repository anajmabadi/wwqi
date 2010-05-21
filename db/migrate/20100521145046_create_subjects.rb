class CreateSubjects < ActiveRecord::Migration
  def self.up
    create_table :subjects do |t|
      t.boolean :major, :default => false
      t.boolean :publish, :default => true
      t.text :notes

      t.timestamps
    end
    Subject.create_translation_table! :name => :string
    add_index :subjects, :publish
    add_index :subjects, :major
    add_index :subject_translations, :name
  end

  def self.down
    remove_index :subjects, :publish
    remove_index :subjects, :major
    remove_index :subject_translations, :name
    Subject.remove_translation_table!
    drop_table :subjects
  end
end
