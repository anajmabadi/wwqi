class AddFieldsToClips < ActiveRecord::Migration
  def self.up
    add_column :clips, :duration, :integer
    add_column :clips, :owner_id, :integer
    
    add_index :clips, [:owner_id], :name => "fk_clips_owners"
  end

  def self.down
    remove_column :clips, :owner_id
    remove_column :clips, :duration
  end
end
