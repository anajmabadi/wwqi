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
  
  it "should require an name" do
    @sample_attributes[:name] = nil
    @clip_type.attributes = @sample_attributes 
    @clip_type.should_not be_valid
  end
  
  it "should require a extension" do
    @sample_attributes[:extension] = nil
    @clip_type.attributes = @sample_attributes 
    @clip_type.should_not be_valid
  end

  it "should require a publish" do
    @sample_attributes[:publish] = nil
    @clip_type.attributes = @sample_attributes 
    @clip_type.should_not be_valid
  end
  
  it "should not allow duplicate calendar types and items" do  
    @clip_type.update_attributes(@sample_attributes)
    @clip_type.should be_valid
    @clip_type2 = ClipType.new(@sample_attributes)
    @clip_type2.should_not be_valid
    lambda { @clip_type2.save(:validate => false) }.should raise_error
  end
    
end
