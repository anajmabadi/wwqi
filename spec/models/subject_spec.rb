require 'spec_helper'

describe Subject do
  before(:each) do
    @subject = Subject.new
    @sample_attributes = {
      :name_en => 'English Name',
      :name_fa => 'Farsi Name',
      :items_count => 0,
      :subject_type_id => 8,
      :publish => true,
      :major => false,
      :notes => 'sample notes'
    }
  end

  it "should be valid" do
    @subject.update_attributes(@sample_attributes)
    @subject.should be_valid
  end
  
  it "should require an English Name" do  
    @sample_attributes[:name_en] = nil
    @subject.update_attributes(@sample_attributes)
    @subject.should_not be_valid
  end

  it "should require a Farsi Name" do  
    @sample_attributes[:name_fa] = nil
    @subject.update_attributes(@sample_attributes)
    @subject.should_not be_valid
  end
    
  it "should require a subject_type_id" do  
    @sample_attributes[:subject_type_id] = nil
    @subject.update_attributes(@sample_attributes)
    @subject.should_not be_valid
  end
  
  it "should require a publish choice" do  
    @sample_attributes[:publish] = nil
    @subject.update_attributes(@sample_attributes)
    @subject.should_not be_valid
  end
    
  it "should require a major" do
    @sample_attributes[:major] = nil
    @subject.update_attributes(@sample_attributes)
    @subject.should_not be_valid
  end
  
end
