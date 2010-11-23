class AddYearMonthDayToItems < ActiveRecord::Migration
    def self.up
        add_column :items, :year, :integer
        add_column :items, :month, :integer
        add_column :items, :day, :integer
        add_index :items, [:year, :month, :day]
    end

    def self.down
        remove_index :items, [:year, :month, :day]
        remove_column :items, :day
        remove_column :items, :month
        remove_column :items, :year
    end
end
