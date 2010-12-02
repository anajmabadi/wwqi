class AddSortYearMonthDayToItems < ActiveRecord::Migration
  def self.up
    add_column :items, :sort_year, :integer
    add_column :items, :sort_month, :integer
    add_column :items, :sort_day, :integer

    add_index :items, [:sort_year, :sort_month, :sort_day]

  end

  def self.down

    #remove_index :items, [:sort_year, :sort_month, :sort_day]

    remove_column :items, :sort_day
    remove_column :items, :sort_month
    remove_column :items, :sort_year
  end
end
