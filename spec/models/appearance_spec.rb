require 'spec_helper'

describe Appearance do
  before(:each) do
    @appearance = Appearance.new
    @sample_attributes = {
      :item_id => 1,
      :person_id => 2,
      :position => 1,
      :publish => true,
      :caption => 'Sample caption',
      :notes => 'sample notes'
    }
  end

  it "should be valid" do
    @appearance.update_attributes(@sample_attributes)
    @appearance.should be_valid
  end
  
  it "should require an item_id" do
    @sample_attributes[:item_id] = nil
    @appearance.update_attributes(@sample_attributes)
    @appearance.should_not be_valid
  end
  
  it "should require a person_id" do
    @sample_attributes[:person_id] = nil
    @appearance.update_attributes(@sample_attributes)
    @appearance.should_not be_valid
  end
  
  it "should require a position" do
    @sample_attributes[:position] = nil
    @appearance.update_attributes(@sample_attributes)
    @appearance.should_not be_valid
  end
  
  it "should require a numerical position" do  
    @sample_attributes[:position] = 'a'
    @appearance.update_attributes(@sample_attributes)
    @appearance.should_not be_valid
  end
  
  it "should require a publish choice" do  
    @sample_attributes[:publish] = nil
    @appearance.update_attributes(@sample_attributes)
    @appearance.should_not be_valid
  end
  
  it "should not allow duplicate persons and items" do  
    @appearance.update_attributes(@sample_attributes)
    @appearance.should be_valid
    @appearance2 = Appearance.new(@sample_attributes)
    @appearance2.should_not be_valid
  end
end
