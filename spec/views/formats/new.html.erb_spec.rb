require 'spec_helper'

describe "formats/new.html.erb" do
  before(:each) do
    assign(:format, stub_model(Format,
      :new_record? => true,
      :name => "MyString",
      :extension => "MyString",
      :publish => false,
      :notes => "MyText"
    ))
  end

  it "renders new format form" do
    render

    response.should have_selector("form", :action => formats_path, :method => "post") do |form|
      form.should have_selector("input#format_name", :name => "format[name]")
      form.should have_selector("input#format_extension", :name => "format[extension]")
      form.should have_selector("input#format_publish", :name => "format[publish]")
      form.should have_selector("textarea#format_notes", :name => "format[notes]")
    end
  end
end
