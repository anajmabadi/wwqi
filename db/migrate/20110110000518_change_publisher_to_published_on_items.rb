class ChangePublisherToPublishedOnItems < ActiveRecord::Migration
  def self.up
    rename_column :item_translations, :publisher, :published
  end

  def self.down
    rename_column :item_translations, :published, :publisher
  end
end
