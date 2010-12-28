class AddTranslatedCaptionToPlots < ActiveRecord::Migration
  def self.up
    Plot.create_translation_table! :caption => :string
    add_index :plot_translations, :locale
    add_index :plot_translations, [:locale, :plot_id], :unique => true
    add_index :plot_translations, :caption
  end

  def self.down
    remove_index :plot_translations, :locale
    remove_index :plot_translations, [:locale, :plot_id]
    remove_index :plot_translations, :caption  
    Plot.drop_translation_table! 
  end
end
