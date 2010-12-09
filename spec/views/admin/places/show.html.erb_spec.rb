require 'spec_helper'

describe "places/show.html.erb" do
  before(:each) do
    assign(:place, @place = stub_model(Place,
      :name => "MyString",
      :latitude => "MyString",
      :longitude => "MyString",
      :x => 1,
      :y => 1,
      :publish => false,
      :notes => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    response.should contain("MyString")
    response.should contain("MyString")
    response.should contain("MyString")
    response.should contain(1)
    response.should contain(1)
    response.should contain(false)
    response.should contain("MyText")
  end
end
