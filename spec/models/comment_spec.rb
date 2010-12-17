require 'spec_helper'

describe Comment do
    before(:each) do
    @comment = Comment.new
    @sample_attributes = {
      :name => "MyName",
      :email => "cforcey@historicusinc.com",
      :body => "My Body",
      :subject => "My Caption",
      :replied_at => Date.new,
      :submitted_at => Date.new,
      :ip => "1.1.1.1",
      :notes => 'sample notes',
      :math_problem => 2
    }
  end

  it "should be valid" do
    @comment.update_attributes(@sample_attributes)
    @comment.should be_valid
  end
  
  it "should require a name" do  
    @sample_attributes[:name] = nil
    @comment.update_attributes(@sample_attributes)
    @comment.should_not be_valid
  end
  
  it "should require an email" do  
    @sample_attributes[:email] = nil
    @comment.update_attributes(@sample_attributes)
    @comment.should_not be_valid
  end
  
  it "should require a body" do  
    @sample_attributes[:body] = nil
    @comment.update_attributes(@sample_attributes)
    @comment.should_not be_valid
  end

  it "should require a correct math answer" do  
    @sample_attributes[:math_problem] = 99
    @comment.update_attributes(@sample_attributes)
    @comment.should_not be_valid
  end    
end
