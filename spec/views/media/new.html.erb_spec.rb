require 'spec_helper'

describe "media/new.html.erb" do
  before(:each) do
    assign(:medium, stub_model(Medium,
      :new_record? => true,
      :name => "MyString",
      :description => "MyText",
      :position => 1,
      :publish => false,
      :notes => "MyText"
    ))
  end

  it "renders new medium form" do
    render

    response.should have_selector("form", :action => media_path, :method => "post") do |form|
      form.should have_selector("input#medium_name", :name => "medium[name]")
      form.should have_selector("textarea#medium_description", :name => "medium[description]")
      form.should have_selector("input#medium_position", :name => "medium[position]")
      form.should have_selector("input#medium_publish", :name => "medium[publish]")
      form.should have_selector("textarea#medium_notes", :name => "medium[notes]")
    end
  end
end
