require 'spec_helper'

describe "collections/index.html.erb" do
  before(:each) do
    assign(:collections, [
      stub_model(Collection,
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
      ),
      stub_model(Collection,
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
      )
    ])
  end

  it "renders a list of collections" do
    render
    response.should have_selector("tr>td", :content => "MyString".to_s, :count => 2)
    response.should have_selector("tr>td", :content => "MyString".to_s, :count => 2)
    response.should have_selector("tr>td", :content => "MyString".to_s, :count => 2)
    response.should have_selector("tr>td", :content => "MyString".to_s, :count => 2)
    response.should have_selector("tr>td", :content => "MyString".to_s, :count => 2)
    response.should have_selector("tr>td", :content => "MyString".to_s, :count => 2)
    response.should have_selector("tr>td", :content => "MyString".to_s, :count => 2)
    response.should have_selector("tr>td", :content => "MyString".to_s, :count => 2)
    response.should have_selector("tr>td", :content => "MyString".to_s, :count => 2)
    response.should have_selector("tr>td", :content => "MyString".to_s, :count => 2)
    response.should have_selector("tr>td", :content => "MyText".to_s, :count => 2)
  end
end
