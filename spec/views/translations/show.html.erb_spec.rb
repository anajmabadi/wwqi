require 'spec_helper'

describe "translations/show.html.erb" do
  before(:each) do
    assign(:translation, @translation = stub_model(Translation,
      :locale => "MyString",
      :key => "MyString",
      :value => "MyText",
      :interpolations => "MyText",
      :is_proc => false
    ))
  end

  it "renders attributes in <p>" do
    render
    response.should contain("MyString")
    response.should contain("MyString")
    response.should contain("MyText")
    response.should contain("MyText")
    response.should contain(false)
  end
end
