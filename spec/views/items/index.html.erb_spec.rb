require 'spec_helper'

describe "items/index.html.erb" do
  before(:each) do
    assign(:items, [
      stub_model(Item,
        :title => "MyString",
        :accession_num => "MyString",
        :caption => "MyString",
        :description => "MyText",
        :olivia_id => "MyString",
        :urn => "MyString",
        :creator_id => 1,
        :owner_id => 1,
        :collection_id => 1,
        :pages => 1,
        :format_id => 1,
        :display_date => "MyString",
        :dimensions => "MyString",
        :notes => "MyText",
        :place_id => 1,
        :publish => false
      ),
      stub_model(Item,
        :title => "MyString",
        :accession_num => "MyString",
        :caption => "MyString",
        :description => "MyText",
        :olivia_id => "MyString",
        :urn => "MyString",
        :creator_id => 1,
        :owner_id => 1,
        :collection_id => 1,
        :pages => 1,
        :format_id => 1,
        :display_date => "MyString",
        :dimensions => "MyString",
        :notes => "MyText",
        :place_id => 1,
        :publish => false
      )
    ])
  end

  it "renders a list of items" do
    render
    response.should have_selector("tr>td", :content => "MyString".to_s, :count => 2)
    response.should have_selector("tr>td", :content => "MyString".to_s, :count => 2)
    response.should have_selector("tr>td", :content => "MyString".to_s, :count => 2)
    response.should have_selector("tr>td", :content => "MyText".to_s, :count => 2)
    response.should have_selector("tr>td", :content => "MyString".to_s, :count => 2)
    response.should have_selector("tr>td", :content => "MyString".to_s, :count => 2)
    response.should have_selector("tr>td", :content => 1.to_s, :count => 2)
    response.should have_selector("tr>td", :content => 1.to_s, :count => 2)
    response.should have_selector("tr>td", :content => 1.to_s, :count => 2)
    response.should have_selector("tr>td", :content => 1.to_s, :count => 2)
    response.should have_selector("tr>td", :content => 1.to_s, :count => 2)
    response.should have_selector("tr>td", :content => "MyString".to_s, :count => 2)
    response.should have_selector("tr>td", :content => "MyString".to_s, :count => 2)
    response.should have_selector("tr>td", :content => "MyText".to_s, :count => 2)
    response.should have_selector("tr>td", :content => 1.to_s, :count => 2)
    response.should have_selector("tr>td", :content => false.to_s, :count => 2)
  end
end
