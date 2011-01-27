class ConvertTermsToTranslatedFieldOnOwners < ActiveRecord::Migration
  def self.up
    add_column :owner_translations, :restrictions, :text
  end

  def self.down
    remove_column :owner_translations, :restrictions
  end
end
