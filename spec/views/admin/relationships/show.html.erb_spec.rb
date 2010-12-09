require 'spec_helper'

describe "relationships/show.html.erb" do
  before(:each) do
    assign(:relationship, @relationship = stub_model(Relationship,
      :name => "MyString",
      :description => "MyText",
      :position => 1,
      :publish => false,
      :notes => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    response.should contain("MyString")
    response.should contain("MyText")
    response.should contain(1)
    response.should contain(false)
    response.should contain("MyText")
  end
end
