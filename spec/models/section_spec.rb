require 'spec_helper'

describe Section do
  before(:each) do
    @section = Section.new
    @sample_attributes = {
      :item_id => 1,
      :title => 'Sample Title',
      :caption => 'Sample Caption',
      :parent_id => 2,
      :start_page => 1,
      :end_page => 2,
      :start_page_label => 'sample start page label',
      :end_page_label => 'sample end page label',
      :publish => true,
      :notes => 'sample notes'
    }
  end

  it "should be valid" do
    @section.update_attributes(@sample_attributes)
    @section.should be_valid
  end
  
  it "should require an item_id" do
    @sample_attributes[:item_id] = nil
    @section.update_attributes(@sample_attributes)
    @section.should_not be_valid
  end
  
  it "should require a title" do
    @sample_attributes[:title] = nil
    @section.update_attributes(@sample_attributes)
    @section.should_not be_valid
  end
  
  it "should NOT require a parent_id" do
    @sample_attributes[:parent_id] = nil
    @section.update_attributes(@sample_attributes)
    @section.should be_valid
  end
  
  it "should require a start page" do  
    @sample_attributes[:start_page] = nil
    @section.update_attributes(@sample_attributes)
    @section.should_not be_valid
  end
  
 it "should require an end page" do  
    @sample_attributes[:end_page] = nil
    @section.update_attributes(@sample_attributes)
    @section.should_not be_valid
  end
  
  it "should require a publish choice" do  
    @sample_attributes[:publish] = nil
    @section.update_attributes(@sample_attributes)
    @section.should_not be_valid
  end
  
end
