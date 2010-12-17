require 'spec_helper'

describe Comp do
  before(:each) do
    @comp = Comp.new
    @sample_attributes = {
      :item_id => 1,
      :comp_id => 2,
      :position => 1,
      :publish => true,
      :notes => 'sample notes'
    }
  end

  it "should be valid" do
    @comp.update_attributes(@sample_attributes)
    @comp.should be_valid
  end
  
  it "should require an item_id" do
    @sample_attributes[:item_id] = nil
    @comp.update_attributes(@sample_attributes)
    @comp.should_not be_valid
  end
  
  it "should require a comp_id" do
    @sample_attributes[:comp_id] = nil
    @comp.update_attributes(@sample_attributes)
    @comp.should_not be_valid
  end
  
  it "should require a position" do
    @sample_attributes[:position] = nil
    @comp.update_attributes(@sample_attributes)
    @comp.should_not be_valid
  end
  
  it "should require a numerical position" do  
    @sample_attributes[:position] = 'a'
    @comp.update_attributes(@sample_attributes)
    @comp.should_not be_valid
  end
  
  it "should require a publish choice" do  
    @sample_attributes[:publish] = nil
    @comp.update_attributes(@sample_attributes)
    @comp.should_not be_valid
  end
  
  it "should not allow duplicate items and comps" do  
    @comp.update_attributes(@sample_attributes)
    @comp.should be_valid
    @comp2 = Comp.new(@sample_attributes)
    @comp2.should_not be_valid
  end
  
end
