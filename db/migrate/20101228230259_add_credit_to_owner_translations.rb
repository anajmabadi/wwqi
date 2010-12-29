class AddCreditToOwnerTranslations < ActiveRecord::Migration
  def self.up
    add_column :owner_translations, :credit, :string
  end

  def self.down
    remove_column :owner_translations, :credit
  end
end
