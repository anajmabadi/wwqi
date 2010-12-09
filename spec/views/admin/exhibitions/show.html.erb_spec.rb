require 'spec_helper'

describe "exhibitions/show.html.erb" do
  before(:each) do
    assign(:exhibition, @exhibition = stub_model(Exhibition,
      :title => "MyString",
      :caption => "MyString",
      :introduction => "MyText",
      :conclusion => "MyText",
      :author => "MyString",
      :featured => false,
      :publish => false,
      :notes => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    response.should contain("MyString")
    response.should contain("MyString")
    response.should contain("MyText")
    response.should contain("MyText")
    response.should contain("MyString")
    response.should contain(false)
    response.should contain(false)
    response.should contain("MyText")
  end
end
