require 'spec_helper'

describe "owners/show.html.erb" do
  before(:each) do
    assign(:owner, @owner = stub_model(Owner,
      :name => "MyString",
      :address => "MyString",
      :address2 => "MyString",
      :state_province => "MyString",
      :postal_code => "MyString",
      :country => "MyString",
      :telephone => "MyString",
      :email => "MyString",
      :url => "MyString",
      :contact => "MyString",
      :terms => "MyText",
      :notes => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    response.should contain("MyString")
    response.should contain("MyString")
    response.should contain("MyString")
    response.should contain("MyString")
    response.should contain("MyString")
    response.should contain("MyString")
    response.should contain("MyString")
    response.should contain("MyString")
    response.should contain("MyString")
    response.should contain("MyString")
    response.should contain("MyText")
    response.should contain("MyText")
  end
end
