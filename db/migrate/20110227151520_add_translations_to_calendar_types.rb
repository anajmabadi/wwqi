class AddTranslationsToCalendarTypes < ActiveRecord::Migration
  def self.up
  	remove_column :calendar_types, :name
  	CalendarType.create_translation_table! :name => :string
  end

  def self.down
  	CalendarType.drop_translation_table! 
  	add_column :calendar_types, :name, :string, :null => false
  end
end
