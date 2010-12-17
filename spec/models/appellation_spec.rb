require 'spec_helper'

describe Appellation do
  before(:each) do
    @appellation = Appellation.new
    @sample_attributes = {
      :person_id => 1,
      :position => 1,
      :publish => true,
      :name_en => 'Sample name',
      :sort_name_en => 'Sort name',
      :name_fa => 'Sample name',
      :sort_name_fa => 'Sort name',
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
  
  it "should require a name_en" do
    @sample_attributes[:name_en] = nil
    @appellation.update_attributes(@sample_attributes)
    @appellation.should_not be_valid
  end
  
  it "should require a name_fa" do
    @sample_attributes[:name_en] = nil
    @appellation.update_attributes(@sample_attributes)
    @appellation.should_not be_valid
  end
  
  it "should require a sort_name_en" do
    @sample_attributes[:name_en] = nil
    @appellation.update_attributes(@sample_attributes)
    @appellation.should_not be_valid
  end
  
    it "should require a sort_name_fa" do
    @sample_attributes[:name_en] = nil
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
  
end
