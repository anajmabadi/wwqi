class CreatePeople < ActiveRecord::Migration
  def self.up
    create_table :people do |t|
      t.string :loc_name
      t.date :dob
      t.date :dod
      t.text :notes
      t.timestamps
    end
    Person.create_translation_table! :name=>:string, :sort_name => :string, :description => :text, :vitals => :string, :birth_place => :string
  end

  def self.down
    drop_table :people
    Person.drop_translation_table! 
  end
end
