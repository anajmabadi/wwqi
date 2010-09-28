require 'spec_helper'

describe "calendar_types/edit.html.erb" do
  before(:each) do
    assign(:calendar_type, @calendar_type = stub_model(CalendarType,
      :new_record? => false,
      :name => "MyString",
      :publish => false,
      :notes => "MyText"
    ))
  end

  it "renders the edit calendar_type form" do
    render

    response.should have_selector("form", :action => admin_calendar_type_path(@calendar_type), :method => "post") do |form|
      form.should have_selector("input#calendar_type_name", :name => "calendar_type[name]")
      form.should have_selector("input#calendar_type_publish", :name => "calendar_type[publish]")
      form.should have_selector("textarea#calendar_type_notes", :name => "calendar_type[notes]")
    end
  end
end
