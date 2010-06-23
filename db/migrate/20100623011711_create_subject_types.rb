class CreateSubjectTypes < ActiveRecord::Migration
  def self.up
    create_table :subject_types do |t|
      t.boolean :publish
      t.text :notes

      t.timestamps
    end
    SubjectType.create_translation_table! :name => :string, :description => :text
    add_index :subject_type_translations, :name
    add_index :subject_types, :publish
  end

  def self.down
    remove_index :subject_type_translations, :name
    remove_index :subject_types, :publish
    SubjectType.drop_translation_table! 
    drop_table :subject_types
  end
end
