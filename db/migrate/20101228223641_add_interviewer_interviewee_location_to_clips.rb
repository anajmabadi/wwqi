class AddInterviewerIntervieweeLocationToClips < ActiveRecord::Migration
  def self.up
    add_column :clip_translations, :interviewer, :string
    add_column :clip_translations, :interviewee, :string
    add_column :clip_translations, :location, :string
  end

  def self.down
    remove_column :clip_translations, :interviewer, :string
    remove_column :clip_translations, :interviewee, :string
    remove_column :clip_translations, :location, :string
  end
end
