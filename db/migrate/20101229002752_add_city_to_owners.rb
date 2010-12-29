class AddCityToOwners < ActiveRecord::Migration
  def self.up
    add_column :owners, :city, :string
  end

  def self.down
    remove_column :owners, :city
  end
end
