require 'spec_helper'

describe "subjects/show.html.erb" do
  before(:each) do
    assign(:subject, @subject = stub_model(Subject,
      :name => "MyString",
      :major => false,
      :publish => false,
      :notes => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    response.should contain("MyString")
    response.should contain(false)
    response.should contain(false)
    response.should contain("MyText")
  end
end
