require 'spec_helper'

describe "images/show.html.erb" do
  before(:each) do
    assign(:image, @image = stub_model(Image,
      :title => "MyString",
      :description => "MyString",
      :dimensions => "MyString",
      :verso => false,
      :position => 1,
      :notes => "MyText",
      :publish => false
    ))
  end

  it "renders attributes in <p>" do
    render
    response.should contain("MyString")
    response.should contain("MyString")
    response.should contain("MyString")
    response.should contain(false)
    response.should contain(1)
    response.should contain("MyText")
    response.should contain(false)
  end
end
