require 'spec_helper'

describe Image do
  before(:each) do
    @image = Image.new
    @sample_attributes = {
      :item_id => 1,
      :title_en => 'This is my title',
      :title_fa => 'This is my title',
      :description_en => 'This is my title',
      :description_en => 'This is my title',
      :file_name => 'My File',
      :verso => true,
      :width => 1.0,
      :height => 1.2,
      :depth => 1.3,
      :position => 1,
      :publish => true,
      :notes => 'sample notes'
    }
  end

  it "should be valid" do
    @image.update_attributes(@sample_attributes)
    @image.should be_valid
  end
  
  it "should require a item_id" do  
    @sample_attributes[:item_id] = nil
    @image.update_attributes(@sample_attributes)
    @image.should_not be_valid
  end
  
  it "should require a verso choice" do  
    @sample_attributes[:verso] = nil
    @image.update_attributes(@sample_attributes)
    @image.should_not be_valid
  end
  
  it "should require a publish choice" do  
    @sample_attributes[:publish] = nil
    @image.update_attributes(@sample_attributes)
    @image.should_not be_valid
  end
    
  it "should require a position" do
    @sample_attributes[:position] = nil
    @image.update_attributes(@sample_attributes)
    @image.should_not be_valid
  end
  
  it "should require a numerical position" do  
    @sample_attributes[:position] = 'a'
    @image.update_attributes(@sample_attributes)
    @image.should_not be_valid
  end
  
  it "should not allow duplicate position for items" do  
    @image.update_attributes(@sample_attributes)
    @image.should be_valid
    @image2 = Image.new(@sample_attributes)
    @image2.should_not be_valid
  end
end
