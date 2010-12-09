require 'spec_helper'

describe "places/index.html.erb" do
  before(:each) do
    assign(:places, [
      stub_model(Place,
        :name => "MyString",
        :latitude => "MyString",
        :longitude => "MyString",
        :x => 1,
        :y => 1,
        :publish => false,
        :notes => "MyText"
      ),
      stub_model(Place,
        :name => "MyString",
        :latitude => "MyString",
        :longitude => "MyString",
        :x => 1,
        :y => 1,
        :publish => false,
        :notes => "MyText"
      )
    ])
  end

  it "renders a list of places" do
    render
    response.should have_selector("tr>td", :content => "MyString".to_s, :count => 2)
    response.should have_selector("tr>td", :content => "MyString".to_s, :count => 2)
    response.should have_selector("tr>td", :content => "MyString".to_s, :count => 2)
    response.should have_selector("tr>td", :content => 1.to_s, :count => 2)
    response.should have_selector("tr>td", :content => 1.to_s, :count => 2)
    response.should have_selector("tr>td", :content => false.to_s, :count => 2)
    response.should have_selector("tr>td", :content => "MyText".to_s, :count => 2)
  end
end
