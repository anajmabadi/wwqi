class ChangeDatesToYearsInPeriods < ActiveRecord::Migration
  def self.up
    remove_column :periods, :start_date
    add_column :periods, :start_year, :integer
    remove_column :periods, :end_date
    add_column :periods, :end_year, :integer
  end

  def self.down
    remove_column :periods, :start_year
    add_column :periods, :start_date, :integer
    remove_column :periods, :end_year
    add_column :periods, :end_date, :integer
  end
end
