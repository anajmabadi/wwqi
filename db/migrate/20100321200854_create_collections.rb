class CreateCollections < ActiveRecord::Migration
  def self.up
    create_table :collections do |t|
      t.string :address
      t.string :address2
      t.string :city
      t.string :state_province
      t.string :postal_code
      t.string :telephone
      t.string :email
      t.string :website
      t.string :contact
      t.text :notes

      t.timestamps
    end
    Collection.create_translation_table! :name => :string, :caption => :string
  end

  def self.down
    drop_table :collections
    Collection.drop_translation_table!
  end
end
