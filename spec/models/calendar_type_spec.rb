require 'spec_helper'

describe CalendarType do
  before(:each) do
    @calendar_type = CalendarType.new
    @sample_attributes = {
      :name => 'Hello Calendar Type',
      :publish => true,
      :notes => 'sample notes'
    }
  end

  it "should be valid" do
    @calendar_type.update_attributes(@sample_attributes)
    @calendar_type.should be_valid
  end
  
  it "should require a name" do  
    @sample_attributes[:name] = nil
    @calendar_type.update_attributes(@sample_attributes)
    @calendar_type.should_not be_valid
  end
  
  it "should require a publish choice" do  
    @sample_attributes[:publish] = nil
    @calendar_type.update_attributes(@sample_attributes)
    @calendar_type.should_not be_valid
  end
  
  it "should not allow duplicate calendar types and items" do  
    @calendar_type.update_attributes(@sample_attributes)
    @calendar_type.should be_valid
    @calendar_type2 = CalendarType.new(@sample_attributes)
    @calendar_type2.should_not be_valid
  end
end
