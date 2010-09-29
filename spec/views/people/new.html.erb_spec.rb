require 'spec_helper'

describe "people/new.html.erb" do
  before(:each) do
    assign(:person, stub_model(Person,
      :new_record? => true,
      :name => "MyString",
      :description => "MyString",
      :vital_display => "MyString",
      :birth_place => "MyString",
      :loc_name => "MyString",
      :notes => "MyText"
    ))
  end

  it "renders new person form" do
    render

    response.should have_selector("form", :action => admin_people_path, :method => "post") do |form|
      form.should have_selector("input#person_name", :name => "person[name]")
      form.should have_selector("input#person_description", :name => "person[description]")
      form.should have_selector("input#person_vital_display", :name => "person[vital_display]")
      form.should have_selector("input#person_birth_place", :name => "person[birth_place]")
      form.should have_selector("input#person_loc_name", :name => "person[loc_name]")
      form.should have_selector("textarea#person_notes", :name => "person[notes]")
    end
  end
end
