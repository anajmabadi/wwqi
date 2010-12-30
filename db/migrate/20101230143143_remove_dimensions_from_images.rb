class RemoveDimensionsFromImages < ActiveRecord::Migration
  def self.up
    remove_column :images, :dimensions
  end

  def self.down
    add_column :images, :dimensions, :string
  end
end
