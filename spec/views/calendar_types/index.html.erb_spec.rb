require 'spec_helper'

describe "calendar_types/index.html.erb" do
  before(:each) do
    assign(:calendar_types, [
      stub_model(CalendarType,
        :name => "MyString",
        :publish => false,
        :notes => "MyText"
      ),
      stub_model(CalendarType,
        :name => "MyString",
        :publish => false,
        :notes => "MyText"
      )
    ])
  end

  it "renders a list of calendar_types" do
    render
    response.should have_selector("tr>td", :content => "MyString".to_s, :count => 2)
    response.should have_selector("tr>td", :content => false.to_s, :count => 2)
    response.should have_selector("tr>td", :content => "MyText".to_s, :count => 2)
  end
end
