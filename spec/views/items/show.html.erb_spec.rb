require 'spec_helper'

describe "items/show.html.erb" do
  before(:each) do
    assign(:item, @item = stub_model(Item,
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
    ))
  end

  it "renders attributes in <p>" do
    render
    response.should contain("MyString")
    response.should contain("MyString")
    response.should contain("MyString")
    response.should contain("MyText")
    response.should contain("MyString")
    response.should contain("MyString")
    response.should contain(1)
    response.should contain(1)
    response.should contain(1)
    response.should contain(1)
    response.should contain(1)
    response.should contain("MyString")
    response.should contain("MyString")
    response.should contain("MyText")
    response.should contain(1)
    response.should contain(false)
  end
end
