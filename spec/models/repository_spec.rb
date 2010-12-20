require 'spec_helper'

describe Repository do
    before(:each) do
    @repository = Repository.new
    @sample_attributes = {
      :name_en => 'Hello Calendar Type',
      :name_fa => 'Hello Persian',
      :url => 'url for me',
      :owner_id => '3',
      :publish => true,
      :notes => 'sample notes'
    }
  end

  it "should be valid" do
    @repository.update_attributes(@sample_attributes)
    @repository.should be_valid
  end
  
  it "should require an English name" do  
    @sample_attributes[:name_en] = nil
    @repository.update_attributes(@sample_attributes)
    @repository.should_not be_valid
  end
  
  it "should require a Persian name" do  
    @sample_attributes[:name_fa] = nil
    @repository.update_attributes(@sample_attributes)
    @repository.should_not be_valid
  end
  
  it "should require a publish choice" do  
    @sample_attributes[:publish] = nil
    @repository.update_attributes(@sample_attributes)
    @repository.should_not be_valid
  end
  
 it "should require an owner id " do  
    @sample_attributes[:owner_id] = nil
    @repository.update_attributes(@sample_attributes)
    @repository.should_not be_valid
  end
  
  it "should not allow duplicate repositories" do  
    @repository.update_attributes(@sample_attributes)
    @repository.should be_valid
    @repository2 = Repository.new(@sample_attributes)
    @repository2.should_not be_valid
  end
end
