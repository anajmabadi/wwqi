require 'spec_helper'

describe "formats/show.html.erb" do
  before(:each) do
    assign(:format, @format = stub_model(Format,
      :name => "MyString",
      :extension => "MyString",
      :publish => false,
      :notes => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    response.should contain("MyString")
    response.should contain("MyString")
    response.should contain(false)
    response.should contain("MyText")
  end
end
