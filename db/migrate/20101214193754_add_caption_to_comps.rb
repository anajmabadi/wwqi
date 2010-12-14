class AddCaptionToComps < ActiveRecord::Migration
  def self.up
    Comp.create_translation_table! :caption => :string
    add_index :comp_translations, :caption
  end

  def self.down
    remove_index :comp_translations, :caption
    Comp.drop_translation_table!
  end
end
