require 'spec_helper'

describe Person do
  before(:each) do
    @person = Person.new
    @sample_attributes = {
      :name_en => "MyName",
      :name_fa => "MyName fa",
      :sort_name_en => "Sort Name",
      :sort_name_fa => "Sort Name fa",
      :description_en => "My description",
      :description_fa => "My description",
      :vitals_en => "Vitals en",
      :vitals_fa => "Vitals fa",
      :birth_place_en => "My birth en",
      :birth_place_fa => "My birth fa",
      :loc_name => "My loc name",
      :major => true,
      :publish => true,
      :country => 'US',
      :dob => 1200,
      :dod => 1000,
      :notes => 'hello'
    }
  end

  it "should be valid" do
    @person.update_attributes(@sample_attributes)
    @person.should be_valid
  end
  
  it "should require an English name" do  
    @sample_attributes[:name_en] = nil
    @person.update_attributes(@sample_attributes)
    @person.should_not be_valid
  end
  
  it "should require a Persian name" do  
    @sample_attributes[:name_fa] = nil
    @person.update_attributes(@sample_attributes)
    @person.should_not be_valid
  end
  
  it "should require an English sort name" do  
    @sample_attributes[:sort_name_en] = nil
    @person.update_attributes(@sample_attributes)
    @person.should_not be_valid
  end
  
  it "should require a Persian sort name" do  
    @sample_attributes[:sort_name_fa] = nil
    @person.update_attributes(@sample_attributes)
    @person.should_not be_valid
  end
  
  it "should require an loc name" do  
    @sample_attributes[:loc_name] = nil
    @person.update_attributes(@sample_attributes)
    @person.should_not be_valid
  end
  
    
  it "should require a publish" do  
    @sample_attributes[:publish] = nil
    @person.update_attributes(@sample_attributes)
    @person.should_not be_valid
  end
  
  it "should require a major" do  
    @sample_attributes[:major] = nil
    @person.update_attributes(@sample_attributes)
    @person.should_not be_valid
  end
  
end
