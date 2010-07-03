require 'spec_helper'

describe Subject do
  before(:each) do
    @subject = Subject.new
  end
  
  it "should be invalid without a name" do
    @subject.should_not be_valid
    @subject.errors.on(:name).should == "is required"
    @subject.name = 'some_name'
    @subject.should be_valid
  end
end
