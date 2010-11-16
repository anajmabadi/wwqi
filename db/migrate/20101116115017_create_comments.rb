class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.string :subject
      t.text :body
      t.datetime :submitted_at
      t.string :ip
      t.datetime :replied_at
      t.string :name
      t.string :email
      t.text :notes

      t.timestamps
    end
    
    add_index :comments, :submitted_at
  end

  def self.down
    drop_table :comments
  end
end
