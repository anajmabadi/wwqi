require 'spec_helper'

describe "formats/edit.html.erb" do
  before(:each) do
    assign(:format, @format = stub_model(Format,
      :new_record? => false,
      :name => "MyString",
      :extension => "MyString",
      :publish => false,
      :notes => "MyText"
    ))
  end

  it "renders the edit format form" do
    render

    response.should have_selector("form", :action => format_path(@format), :method => "post") do |form|
      form.should have_selector("input#format_name", :name => "format[name]")
      form.should have_selector("input#format_extension", :name => "format[extension]")
      form.should have_selector("input#format_publish", :name => "format[publish]")
      form.should have_selector("textarea#format_notes", :name => "format[notes]")
    end
  end
end
