require 'spec_helper'

describe Clip do
  
  before(:each) do
    @clip = Clip.new
    @sample_attributes = {
      :title_en => "Sample title",
      :title_fa => "Sample title",
      :caption_en => "Sample caption",
      :caption_fa => "Sample caption",
      :position => 1,
      :publish => 1,
      :item_id => 1,
      :recorded_on => Date.new,
      :clip_type_id => 1,
      :owner_id => 1,
      :duration => 20
    }
  end
  
  it "should be valid" do
    @clip.update_attributes(@sample_attributes)
    @clip.should be_valid
  end
  
  it "should require an item_id" do
    @sample_attributes[:item_id] = nil
    @clip.attributes = @sample_attributes 
    @clip.should_not be_valid
    lambda { @clip.save(:validate => false) }.should raise_error
  end
  
  it "should require a clip_type_id" do
    @sample_attributes[:clip_type_id] = nil
    @clip.attributes = @sample_attributes 
    @clip.should_not be_valid
    lambda { @clip.save(:validate => false) }.should raise_error
  end

  it "should require an English title" do
    @sample_attributes[:title_en] = nil
    @clip.attributes = @sample_attributes 
    @clip.should_not be_valid
  end
  
  it "should require a Parsian title" do
    @sample_attributes[:title_fa] = nil
    @clip.attributes = @sample_attributes 
    @clip.should_not be_valid
  end
  
  it "should require a publish setting" do
    @sample_attributes[:publish] = nil
    @clip.attributes = @sample_attributes 
    @clip.should_not be_valid
    lambda { @clip.save(:validate => false) }.should raise_error
  end
    
  it "should require a position" do
    @sample_attributes[:position] = nil
    @clip.attributes = @sample_attributes 
    @clip.should_not be_valid
    lambda { @clip.save(:validate => false) }.should raise_error
  end
  
  it "should require a numerical position greater than 0 and less than 10000" do
    @sample_attributes[:position] = 0
    @clip.update_attributes(@sample_attributes)
    @clip.should_not be_valid
    @sample_attributes[:position] = 100001
    @clip.update_attributes(@sample_attributes)
    @clip.should_not be_valid
    @sample_attributes[:position] = "abcd"
    @clip.update_attributes(@sample_attributes)
    @clip.should_not be_valid
  end
  
  it "should require a numerical duration greater than 0" do
    @sample_attributes[:duration] = 0
    @clip.update_attributes(@sample_attributes)
    @clip.should_not be_valid
    @sample_attributes[:duration] = "abcd"
    @clip.update_attributes(@sample_attributes)
    @clip.should_not be_valid
  end
  
  it "should return a valid clip file name for a position" do
    @clip.update_attributes(@sample_attributes)
    @clip.clip_file_name("wav").should == "it_#{@clip.item_id.to_s}_#{@clip.position.to_s}_clip.wav"
  end
  
  it "should return a valid clip url for a position" do
    @clip.update_attributes(@sample_attributes)
    @clip.clip_url("wav").should == "http://library.qajarwomen.org/clips/it_#{@clip.item_id.to_s}_#{@clip.position.to_s}_clip.wav"
  end
  
end
