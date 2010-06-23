require 'spec_helper'

describe "subject_types/edit.html.erb" do
  before(:each) do
    assign(:subject_type, @subject_type = stub_model(SubjectType,
      :new_record? => false,
      :name => "MyString",
      :description => "MyText",
      :publish => false,
      :notes => "MyText"
    ))
  end

  it "renders the edit subject_type form" do
    render

    rendered.should have_selector("form", :action => subject_type_path(@subject_type), :method => "post") do |form|
      form.should have_selector("input#subject_type_name", :name => "subject_type[name]")
      form.should have_selector("textarea#subject_type_description", :name => "subject_type[description]")
      form.should have_selector("input#subject_type_publish", :name => "subject_type[publish]")
      form.should have_selector("textarea#subject_type_notes", :name => "subject_type[notes]")
    end
  end
end
