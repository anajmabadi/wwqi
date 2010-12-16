require 'spec_helper'

describe ClipType do
  before(:each) do
    @clip_type = ClipType.new
    @sample_attributes = {
      :name => "Sample title",
      :extension => "wav",
      :publish => true,
      :notes => "sample note"
    }
  end

  after(:each) do
    @clip_type.destroy
  end
  
  it "should be valid" do
    @clip_type.update_attributes(@sample_attributes)
    @clip_type.should be_valid
  end
  
  it "should require an item_id" do
    @sample_attributes[:item_id] = nil
    @clip_type.attributes = @sample_attributes 
    @clip_type.should_not be_valid
    lambda { @clip_type.save(:validate => false) }.should raise_error
  end
  
  it "should require a clip_type_type_id" do
    @sample_attributes[:clip_type_type_id] = nil
    @clip_type.attributes = @sample_attributes 
    @clip_type.should_not be_valid
    lambda { @clip_type.save(:validate => false) }.should raise_error
  end

  it "should require a title" do
    @sample_attributes[:title] = nil
    @clip_type.attributes = @sample_attributes 
    @clip_type.should_not be_valid
  end
    
  it "should require a position" do
    @sample_attributes[:position] = nil
    @clip_type.attributes = @sample_attributes 
    @clip_type.should_not be_valid
    lambda { @clip_type.save(:validate => false) }.should raise_error
  end
  
  it "should require a numerical position greater than 0 and less than 10000" do
    @sample_attributes[:position] = 0
    @clip_type.update_attributes(@sample_attributes)
    @clip_type.should_not be_valid
    @sample_attributes[:position] = 100001
    @clip_type.update_attributes(@sample_attributes)
    @clip_type.should_not be_valid
    @sample_attributes[:position] = "abcd"
    @clip_type.update_attributes(@sample_attributes)
    @clip_type.should_not be_valid
  end
  
  it "should return a valid clip_type file name for a position" do
    @clip_type.update_attributes(@sample_attributes)
    @clip_type.clip_type_file_name("wav").should == "it_#{@clip_type.item_id.to_s}_#{@clip_type.position.to_s}_clip_type.wav"
  end
  
  it "should return a valid clip_type url for a position" do
    @clip_type.update_attributes(@sample_attributes)
    @clip_type.clip_type_url("wav").should == "http://library.qajarwomen.org/clip_types/it_#{@clip_type.item_id.to_s}_#{@clip_type.position.to_s}_clip_type.wav"
  end
end
