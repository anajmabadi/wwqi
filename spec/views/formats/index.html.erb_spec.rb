require 'spec_helper'

describe "formats/index.html.erb" do
  before(:each) do
    assign(:formats, [
      stub_model(Format,
        :name => "MyString",
        :extension => "MyString",
        :publish => false,
        :notes => "MyText"
      ),
      stub_model(Format,
        :name => "MyString",
        :extension => "MyString",
        :publish => false,
        :notes => "MyText"
      )
    ])
  end

  it "renders a list of formats" do
    render
    response.should have_selector("tr>td", :content => "MyString".to_s, :count => 2)
    response.should have_selector("tr>td", :content => "MyString".to_s, :count => 2)
    response.should have_selector("tr>td", :content => false.to_s, :count => 2)
    response.should have_selector("tr>td", :content => "MyText".to_s, :count => 2)
  end
end
