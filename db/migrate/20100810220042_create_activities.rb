class CreateActivities < ActiveRecord::Migration
  def self.up
    create_table :activities do |t|
      t.string :browser, :null => false
      t.string :session_id, :null => false
      t.string :ip_address, :null => false
      t.integer :user_id
      t.string :action
      t.string :params
      t.integer :collection_id
      t.integer :period_id
      t.integer :item_id
      t.integer :page_id
      t.integer :person_id
      t.integer :subject_id
      t.integer :subject_type_id
      t.integer :place_id
      t.boolean :success, :null => false, :default => false

      t.timestamps
    end
    add_index :activities, :item_id
    add_index :activities, :period_id
    add_index :activities, :person_id
    add_index :activities, :page_id
    add_index :activities, :user_id
    add_index :activities, :collection_id 
    add_index :activities, :subject_type_id
    add_index :activities, :subject_id
    add_index :activities, :place_id
  end

  def self.down
    remove_index :activities, :item_id
    remove_index :activities, :period_id
    remove_index :activities, :person_id
    remove_index :activities, :page_id
    remove_index :activities, :user_id
    remove_index :activities, :collection_id
    remove_index :activities, :subject_type_id
    remove_index :activities, :subject_id
    remove_index :activities, :place_id
    drop_table :activities
  end
end
