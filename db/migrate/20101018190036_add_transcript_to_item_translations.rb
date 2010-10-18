class AddTranscriptToItemTranslations < ActiveRecord::Migration
  def self.up
    add_column :item_translations, :transcript, :text
  end

  def self.down
    remove_column :item_translations, :transcript
  end
end
