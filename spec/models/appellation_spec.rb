require 'spec_helper'

describe Appellation do
  before(:each) do
    @appellation = Appellation.new
    @sample_attributes = {
      :person_id => 1,
      :position => 1,
      :publish => true,
      :name => 'Sample name',
      :sort_name => 'Sort name',
      :notes => 'sample notes'
    }
  end

  it "should be valid" do
    @appellation.update_attributes(@sample_attributes)
    @appellation.should be_valid
  end
  
  it "should require an person_id" do
    @sample_attributes[:person_id] = nil
    @appellation.update_attributes(@sample_attributes)
    @appellation.should_not be_valid
  end
  
  it "should require a person_id" do
    @sample_attributes[:person_id] = nil
    @appellation.update_attributes(@sample_attributes)
    @appellation.should_not be_valid
  end
  
  it "should require a position" do
    @sample_attributes[:position] = nil
    @appellation.update_attributes(@sample_attributes)
    @appellation.should_not be_valid
  end
  
  it "should require a numerical position" do  
    @sample_attributes[:position] = 'a'
    @appellation.update_attributes(@sample_attributes)
    @appellation.should_not be_valid
  end
  
  it "should require a publish choice" do  
    @sample_attributes[:publish] = nil
    @appellation.update_attributes(@sample_attributes)
    @appellation.should_not be_valid
  end
  
  it "should not allow duplicate appellations" do  
    @appellation.update_attributes(@sample_attributes)
    @appellation.should be_valid
    @appellation2 = Appearance.new(@sample_attributes)
    @appellation2.should_not be_valid
  end
end
