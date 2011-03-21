class RemoverCreatorLabelFromItemTranslations < ActiveRecord::Migration
  def self.up
  	remove_column :item_translations, :creator_label 
  end

  def self.down
  	add_column :item_translations, :creator_label, :string
  end
end
