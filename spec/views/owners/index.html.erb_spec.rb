require 'spec_helper'

describe "owners/index.html.erb" do
  before(:each) do
    assign(:owners, [
      stub_model(Owner,
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
      ),
      stub_model(Owner,
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
      )
    ])
  end

  it "renders a list of owners" do
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
    response.should have_selector("tr>td", :content => "MyText".to_s, :count => 2)
  end
end
