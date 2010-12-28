require 'spec_helper'

describe Plot do
  before(:each) do
    @plot = Plot.new
    @sample_attributes = {
      :item_id => 1,
      :place_id => 1,
      :position => 1,
      :caption_en => 'This is my short caption',
      :caption_fa => 'This is my long caption',
      :publish => true,
      :position => 1,
      :notes => 'sample notes'
    }
  end

  it "should be valid" do
    @plot.update_attributes(@sample_attributes)
    @plot.should be_valid
  end
  
  it "should require a item_id" do  
    @sample_attributes[:item_id] = nil
    @plot.update_attributes(@sample_attributes)
    @plot.should_not be_valid
  end
  
  it "should require a placce_id" do  
    @sample_attributes[:place_id] = nil
    @plot.update_attributes(@sample_attributes)
    @plot.should_not be_valid
  end
  
  it "should require a publish choice" do  
    @sample_attributes[:publish] = nil
    @plot.update_attributes(@sample_attributes)
    @plot.should_not be_valid
  end
    
  it "should require a position" do
    @sample_attributes[:position] = nil
    @plot.update_attributes(@sample_attributes)
    @plot.should_not be_valid
  end
  
  it "should require a numerical position" do  
    @sample_attributes[:position] = 'a'
    @plot.update_attributes(@sample_attributes)
    @plot.should_not be_valid
  end
  
  it "should not allow duplicate place and items" do  
    @plot.update_attributes(@sample_attributes)
    @plot.should be_valid
    @plot2 = Plot.new(@sample_attributes)
    @plot2.should_not be_valid
  end
end
