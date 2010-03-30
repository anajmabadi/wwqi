require 'spec_helper'

describe "periods/index.html.erb" do
  before(:each) do
    assign(:periods, [
      stub_model(Period,
        :title => "MyString",
        :caption => "MyString",
        :description => "MyText",
        :position => 1,
        :publish => false,
        :notes => "MyText"
      ),
      stub_model(Period,
        :title => "MyString",
        :caption => "MyString",
        :description => "MyText",
        :position => 1,
        :publish => false,
        :notes => "MyText"
      )
    ])
  end

  it "renders a list of periods" do
    render
    response.should have_selector("tr>td", :content => "MyString".to_s, :count => 2)
    response.should have_selector("tr>td", :content => "MyString".to_s, :count => 2)
    response.should have_selector("tr>td", :content => "MyText".to_s, :count => 2)
    response.should have_selector("tr>td", :content => 1.to_s, :count => 2)
    response.should have_selector("tr>td", :content => false.to_s, :count => 2)
    response.should have_selector("tr>td", :content => "MyText".to_s, :count => 2)
  end
end
