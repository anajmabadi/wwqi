class CreateAdminAppellations < ActiveRecord::Migration
  def self.up
    create_table :admin_appellations do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :admin_appellations
  end
end
