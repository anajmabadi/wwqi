require 'spec_helper'

describe Classification do
  before(:each) do
    @classification = Classification.new
    @sample_attributes = {
      :item_id => 1,
      :subject_id => 1,
      :position => 1,
      :publish => true,
      :notes => 'sample notes'
    }
  end

  it "should be valid" do
    @classification.update_attributes(@sample_attributes)
    @classification.should be_valid
  end
  
  it "should require a item_id" do  
    @sample_attributes[:item_id] = nil
    @classification.update_attributes(@sample_attributes)
    @classification.should_not be_valid
  end
  
  it "should require a subject_id" do  
    @sample_attributes[:subject_id] = nil
    @classification.update_attributes(@sample_attributes)
    @classification.should_not be_valid
  end
  
  it "should require a publish choice" do  
    @sample_attributes[:publish] = nil
    @classification.update_attributes(@sample_attributes)
    @classification.should_not be_valid
  end
    
  it "should require a position" do
    @sample_attributes[:position] = nil
    @classification.update_attributes(@sample_attributes)
    @classification.should_not be_valid
  end
  
  it "should require a numerical position" do  
    @sample_attributes[:position] = 'a'
    @classification.update_attributes(@sample_attributes)
    @classification.should_not be_valid
  end
  
  it "should not allow duplicate subject_id and items" do  
    @classification.update_attributes(@sample_attributes)
    @classification.should be_valid
    @classification2 = Classification.new(@sample_attributes)
    @classification2.should_not be_valid
  end
end
