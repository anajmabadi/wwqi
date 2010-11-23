class AddEraIdtoItems < ActiveRecord::Migration
  def self.up
      add_column :items, :era_id, :integer
  end

  def self.down
      remove_column :items, :era_id
  end
end
