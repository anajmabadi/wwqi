class ChangeDobDodToYearsInPeopleTable < ActiveRecord::Migration
  def self.up
    change_column(:people, :dob, :string)
    change_column(:people, :dod, :string)
    @people = Person.find(:all)
    @people.each do |person|
      person.dob = person.dob[0..3] unless person.dob.nil?
      person.dod = person.dod[0..3] unless person.dod.nil?
      person.save
    end
    change_column(:people, :dob, :integer)
    change_column(:people, :dod, :integer)
  end

  def self.down
    change_column(:people, :dob, :date)
    change_column(:people, :dod, :date)
  end
end
