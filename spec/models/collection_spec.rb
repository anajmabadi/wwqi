require 'spec_helper'

describe Collection do
  before(:each) do
    @collection = Collection.new
    @sample_attributes = {
      :address => "Sample address",
      :address2 => "Sample address2",
      :city => "City",
      :state_province => "State",
      :postal_code => "Postal Code",
      :telephone => "122333444",
      :email => "hello",
      :website => "jfjfjf",
      :contact => "chchch",
      :private => true,
      :items_count => 100,
      :finding_aid => true,
      :acquired_on => Date.new,
      :processed_by => 'df',
      :acquisition_notes => 'kdkdkd',
      :last_edited => Date.new,
      :name => "Sample Name",
      :caption => "Sample Collection",
      :description => "Sample Description",
      :sort_name => "Sort Name",
      :dates => "Dates",
      :materials => "Materials",
      :repository => "Repository",
      :tips => "Tips",
      :creator => "test",
      :restrictions => "Restrictions",
      :history => "History",
      :publish => true,
      :notes => "sample note"
    }
  end
  
  it "should be valid" do
    @collection.update_attributes(@sample_attributes)
    @collection.should be_valid
  end
  
  it "should require an name" do
    @sample_attributes[:name] = nil
    @collection.attributes = @sample_attributes 
    @collection.should_not be_valid
  end
  
  it "should require a sort_name" do
    @sample_attributes[:sort_name] = nil
    @collection.attributes = @sample_attributes 
    @collection.should_not be_valid
  end

  it "should require a publish" do
    @sample_attributes[:publish] = nil
    @collection.attributes = @sample_attributes 
    @collection.should_not be_valid
  end
  
  it "should require a private" do
    @sample_attributes[:private] = nil
    @collection.attributes = @sample_attributes 
    @collection.should_not be_valid
  end
  
  it "should require a finding aid" do
    @sample_attributes[:finding_aid] = nil
    @collection.attributes = @sample_attributes 
    @collection.should_not be_valid
  end
  
end
