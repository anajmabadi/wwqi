require 'spec_helper'

describe "media/edit.html.erb" do
  before(:each) do
    assign(:medium, @medium = stub_model(Medium,
      :new_record? => false,
      :name => "MyString",
      :description => "MyText",
      :position => 1,
      :publish => false,
      :notes => "MyText"
    ))
  end

  it "renders the edit medium form" do
    render

    response.should have_selector("form", :action => medium_path(@medium), :method => "post") do |form|
      form.should have_selector("input#medium_name", :name => "medium[name]")
      form.should have_selector("textarea#medium_description", :name => "medium[description]")
      form.should have_selector("input#medium_position", :name => "medium[position]")
      form.should have_selector("input#medium_publish", :name => "medium[publish]")
      form.should have_selector("textarea#medium_notes", :name => "medium[notes]")
    end
  end
end
