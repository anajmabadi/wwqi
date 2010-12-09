require 'spec_helper'

describe "pages/index.html.erb" do
  before(:each) do
    assign(:pages, [
      stub_model(Page,
        :title => "MyString",
        :caption => "MyText",
        :body => "MyText",
        :publish => false,
        :notes => "MyText"
      ),
      stub_model(Page,
        :title => "MyString",
        :caption => "MyText",
        :body => "MyText",
        :publish => false,
        :notes => "MyText"
      )
    ])
  end

  it "renders a list of pages" do
    render
    response.should have_selector("tr>td", :content => "MyString".to_s, :count => 2)
    response.should have_selector("tr>td", :content => "MyText".to_s, :count => 2)
    response.should have_selector("tr>td", :content => "MyText".to_s, :count => 2)
    response.should have_selector("tr>td", :content => false.to_s, :count => 2)
    response.should have_selector("tr>td", :content => "MyText".to_s, :count => 2)
  end
end
