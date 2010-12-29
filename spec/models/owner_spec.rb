require 'spec_helper'

describe Owner do
  before(:each) do
    @owner = Owner.new
    @sample_attributes = {
      :name_en => "Sample string",
      :name_fa => "Sample string",
      :credit_en => "Sample string",
      :credit_fa => "Sample string",
      :address => "Sample string",
      :address2 => "Sample string",
      :city => "Sample string",
      :state_province => "Sample string",
      :postal_code => "Sample string",
      :country => "Sample string",
      :telephone => "Sample string",
      :email => "Sample string",
      :url => "Sample string",
      :contact => "Sample string",
      :terms => 'This is my short caption',
      :notes => 'This is my long caption',
      :private => true
    }
  end

  it "should be valid" do
    @owner.update_attributes(@sample_attributes)
    @owner.should be_valid
  end
  
  it "should require a name_en" do  
    @sample_attributes[:name_en] = nil
    @owner.update_attributes(@sample_attributes)
    @owner.should_not be_valid
  end
  
  it "should require a name_fa" do  
    @sample_attributes[:name_fa] = nil
    @owner.update_attributes(@sample_attributes)
    @owner.should_not be_valid
  end
  
  it "should require a private choice" do  
    @sample_attributes[:private] = nil
    @owner.update_attributes(@sample_attributes)
    @owner.should_not be_valid
  end
    
end
