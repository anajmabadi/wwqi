require 'spec_helper'

describe "images/index.html.erb" do
  before(:each) do
    assign(:images, [
      stub_model(Image,
        :title => "MyString",
        :description => "MyString",
        :dimensions => "MyString",
        :verso => false,
        :position => 1,
        :notes => "MyText",
        :publish => false
      ),
      stub_model(Image,
        :title => "MyString",
        :description => "MyString",
        :dimensions => "MyString",
        :verso => false,
        :position => 1,
        :notes => "MyText",
        :publish => false
      )
    ])
  end

  it "renders a list of images" do
    render
    response.should have_selector("tr>td", :content => "MyString".to_s, :count => 2)
    response.should have_selector("tr>td", :content => "MyString".to_s, :count => 2)
    response.should have_selector("tr>td", :content => "MyString".to_s, :count => 2)
    response.should have_selector("tr>td", :content => false.to_s, :count => 2)
    response.should have_selector("tr>td", :content => 1.to_s, :count => 2)
    response.should have_selector("tr>td", :content => "MyText".to_s, :count => 2)
    response.should have_selector("tr>td", :content => false.to_s, :count => 2)
  end
end
