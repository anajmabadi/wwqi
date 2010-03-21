require 'spec_helper'

describe "people/index.html.erb" do
  before(:each) do
    assign(:people, [
      stub_model(Person,
        :name => "MyString",
        :description => "MyString",
        :vital_display => "MyString",
        :birth_place => "MyString",
        :loc_name => "MyString",
        :notes => "MyText"
      ),
      stub_model(Person,
        :name => "MyString",
        :description => "MyString",
        :vital_display => "MyString",
        :birth_place => "MyString",
        :loc_name => "MyString",
        :notes => "MyText"
      )
    ])
  end

  it "renders a list of people" do
    render
    response.should have_selector("tr>td", :content => "MyString".to_s, :count => 2)
    response.should have_selector("tr>td", :content => "MyString".to_s, :count => 2)
    response.should have_selector("tr>td", :content => "MyString".to_s, :count => 2)
    response.should have_selector("tr>td", :content => "MyString".to_s, :count => 2)
    response.should have_selector("tr>td", :content => "MyString".to_s, :count => 2)
    response.should have_selector("tr>td", :content => "MyText".to_s, :count => 2)
  end
end
