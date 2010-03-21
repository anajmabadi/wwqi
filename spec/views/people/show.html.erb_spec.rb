require 'spec_helper'

describe "people/show.html.erb" do
  before(:each) do
    assign(:person, @person = stub_model(Person,
      :name => "MyString",
      :description => "MyString",
      :vital_display => "MyString",
      :birth_place => "MyString",
      :loc_name => "MyString",
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
    response.should contain("MyText")
  end
end
