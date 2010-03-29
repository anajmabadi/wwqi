require 'spec_helper'

describe "pages/show.html.erb" do
  before(:each) do
    assign(:page, @page = stub_model(Page,
      :title => "MyString",
      :caption => "MyText",
      :body => "MyText",
      :publish => false,
      :notes => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    response.should contain("MyString")
    response.should contain("MyText")
    response.should contain("MyText")
    response.should contain(false)
    response.should contain("MyText")
  end
end
