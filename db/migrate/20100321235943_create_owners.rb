class CreateOwners < ActiveRecord::Migration
  def self.up
    create_table :owners do |t|

      t.string :address
      t.string :address2
      t.string :state_province
      t.string :postal_code
      t.string :country
      t.string :telephone
      t.string :email
      t.string :url
      t.string :contact
      t.text :terms
      t.text :notes

      t.timestamps
    end
    Owner.create_translation_table! :name => :string

    #add a country field to people too
    add_column :people, :country, :string
  end

  def self.down
    drop_table :owners
    Owner.drop_translation_table!
    remove_column :people, :country
  end
end
