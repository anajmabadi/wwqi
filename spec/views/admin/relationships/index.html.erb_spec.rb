require 'spec_helper'

describe "relationships/index.html.erb" do
  before(:each) do
    assign(:relationships, [
      stub_model(Relationship,
        :name => "MyString",
        :description => "MyText",
        :position => 1,
        :publish => false,
        :notes => "MyText"
      ),
      stub_model(Relationship,
        :name => "MyString",
        :description => "MyText",
        :position => 1,
        :publish => false,
        :notes => "MyText"
      )
    ])
  end

  it "renders a list of relationships" do
    render
    response.should have_selector("tr>td", :content => "MyString".to_s, :count => 2)
    response.should have_selector("tr>td", :content => "MyText".to_s, :count => 2)
    response.should have_selector("tr>td", :content => 1.to_s, :count => 2)
    response.should have_selector("tr>td", :content => false.to_s, :count => 2)
    response.should have_selector("tr>td", :content => "MyText".to_s, :count => 2)
  end
end
