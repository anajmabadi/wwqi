class AddCategoryFieldToItems < ActiveRecord::Migration
  def self.up
    add_column :items, :category_id, :integer
    add_column :items, :source_date, :string
    add_column :items, :calendar_id, :integer
    add_index :items, :category_id
  end

  def self.down
   remove_index :items, :category_id
    remove_column :items, :category_id
    remove_column :items, :source_date
    remove_column :itemd, :calendar_id
  end
end
