require 'spec_helper'

describe "collections/show.html.erb" do
  before(:each) do
    assign(:collection, @collection = stub_model(Collection,
      :name => "MyString",
      :address => "MyString",
      :address2 => "MyString",
      :city => "MyString",
      :state_province => "MyString",
      :postal_code => "MyString",
      :telephone => "MyString",
      :email => "MyString",
      :website => "MyString",
      :contact => "MyString",
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
  end
end
