require 'spec_helper'

describe "calendar_types/show.html.erb" do
  before(:each) do
    assign(:calendar_type, @calendar_type = stub_model(CalendarType,
      :name => "MyString",
      :publish => false,
      :notes => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    response.should contain("MyString")
    response.should contain(false)
    response.should contain("MyText")
  end
end
