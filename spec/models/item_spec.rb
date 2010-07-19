require 'spec_helper'

describe Item do
  
  before(:each) do
    @item = Item.new
    @sample_attributes = {
      :title => "Sample title",
      :pages => 1,
      :accession_num => "ABCD-00011"
    }
  end

  it "should be valid" do
    @item.update_attributes(@sample_attributes)
    @item.should be_valid
  end
  
  it "should require a title" do
    @sample_attributes[:title] = nil
    @item.update_attributes(@sample_attributes)
    @item.should_not be_valid
  end
  
  it "should require a title longer than 2 characters and shorter than 255 characters" do
    @sample_attributes[:title] = "12"
    @item.update_attributes(@sample_attributes)
    @item.should_not be_valid
    @sample_attributes[:title] = 'a' * 256
    @item.update_attributes(@sample_attributes)
    @item.should_not be_valid
  end
  
  it "should require an accession_num" do
    @sample_attributes[:accession_num] = nil
    @item.update_attributes(@sample_attributes)
    @item.should_not be_valid
  end
  
  it "should require an accession_num longer than 2 characters and shorter than 255 characters" do
    @sample_attributes[:accession_num] = "12"
    @item.update_attributes(@sample_attributes)
    @item.should_not be_valid
    @sample_attributes[:accession_num] = 'a' * 256
    @item.update_attributes(@sample_attributes)
    @item.should_not be_valid
  end
  
  it "should require pages" do
    @sample_attributes[:pages] = nil
    @item.update_attributes(@sample_attributes)
    @item.should_not be_valid
  end
  
  it "should require a numeric pages" do
    @sample_attributes[:pages] = "should be a number"
    @item.update_attributes(@sample_attributes)
    @item.should_not be_valid
  end
  
  it "should require pages between 1 and 10000" do
    @sample_attributes[:pages] = 0
    @item.update_attributes(@sample_attributes)
    @item.should_not be_valid
    @sample_attributes[:pages] = 10001
    @item.update_attributes(@sample_attributes)
    @item.should_not be_valid
    @sample_attributes[:pages] = -100
    @item.update_attributes(@sample_attributes)
    @item.should_not be_valid  
  end
end