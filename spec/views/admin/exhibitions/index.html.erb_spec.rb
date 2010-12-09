require 'spec_helper'

describe "exhibitions/index.html.erb" do
  before(:each) do
    assign(:exhibitions, [
      stub_model(Exhibition,
        :title => "MyString",
        :caption => "MyString",
        :introduction => "MyText",
        :conclusion => "MyText",
        :author => "MyString",
        :featured => false,
        :publish => false,
        :notes => "MyText"
      ),
      stub_model(Exhibition,
        :title => "MyString",
        :caption => "MyString",
        :introduction => "MyText",
        :conclusion => "MyText",
        :author => "MyString",
        :featured => false,
        :publish => false,
        :notes => "MyText"
      )
    ])
  end

  it "renders a list of exhibitions" do
    render
    response.should have_selector("tr>td", :content => "MyString".to_s, :count => 2)
    response.should have_selector("tr>td", :content => "MyString".to_s, :count => 2)
    response.should have_selector("tr>td", :content => "MyText".to_s, :count => 2)
    response.should have_selector("tr>td", :content => "MyText".to_s, :count => 2)
    response.should have_selector("tr>td", :content => "MyString".to_s, :count => 2)
    response.should have_selector("tr>td", :content => false.to_s, :count => 2)
    response.should have_selector("tr>td", :content => false.to_s, :count => 2)
    response.should have_selector("tr>td", :content => "MyText".to_s, :count => 2)
  end
end
