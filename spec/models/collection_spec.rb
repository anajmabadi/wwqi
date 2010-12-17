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
      :name_en => "Sample Name",
      :name_fa => "Sample Name",
      :caption_en => "Sample Collection",
      :caption_fa => "Sample Collection",
      :description_en => "Sample Description",
      :description_fa => "Sample Description",
      :sort_name_en => "Sort Name",
      :sort_name_fa => "Sort Name",
      :dates_en => "Dates",
      :dates_fa => "Dates",
      :materials_en => "Materials",
      :materials_fa => "Materials",
      :repository_en => "Repository",
      :repository_fa => "Repository",
      :tips_en => "Tips",
      :tips_fa => "Tips",
      :creator_en => "test",
      :creator_fa => "test",
      :restrictions_en => "Restrictions",
      :restrictions_fa => "Restrictions",
      :history_en => "History",
      :history_fa => "History",
      :publish => true,
      :notes => "sample note"
    }
  end
  
  it "should be valid" do
    @collection.update_attributes(@sample_attributes)
    @collection.should be_valid
  end
  
  it "should require an name_en" do
    @sample_attributes[:name_en] = nil
    @collection.attributes = @sample_attributes 
    @collection.should_not be_valid
  end
  
  it "should require an name_fa" do
    @sample_attributes[:name_fa] = nil
    @collection.attributes = @sample_attributes 
    @collection.should_not be_valid
  end
  
  it "should require a sort_name" do
    @sample_attributes[:sort_name_en] = nil
    @collection.attributes = @sample_attributes 
    @collection.should_not be_valid
  end

  it "should require a sort_name" do
    @sample_attributes[:sort_name_fa] = nil
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
