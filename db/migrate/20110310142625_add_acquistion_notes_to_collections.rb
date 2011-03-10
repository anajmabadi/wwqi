# encoding: UTF-8
class AddAcquistionNotesToCollections < ActiveRecord::Migration
  def self.up
  	rename_column :collections, :acquisition_notes, :acquisition_notes_old
  	add_column :collection_translations, :acquisition_notes, :text
  	
  	@collections = Collection.where('acquisition_notes_old IS NOT NULL').all
  	@collections.each do |collection|
  		unless collection.acquisition_notes_old.blank?
  			collection.acquisition_notes_en = collection.acquisition_notes_old 
  			collection.acquisition_notes_fa = "ترجمه از دست رفته" 
  			collection.save
  		end
  	end
  	
  end

  def self.down
  	
  	remove_column :collection_translations, :acquisition_notes
  	rename_column :collections, :acquisition_notes_old, :acquisition_notes
  	
  end
end
