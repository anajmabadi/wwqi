require 'spec_helper'

describe "subjects/edit.html.erb" do
  before(:each) do
    assign(:subject, @subject = stub_model(Subject,
      :new_record? => false,
      :name => "MyString",
      :major => false,
      :publish => false,
      :notes => "MyText"
    ))
  end

  it "renders the edit subject form" do
    render

    response.should have_selector("form", :action => admin_subject_path(@subject), :method => "post") do |form|
      form.should have_selector("input#subject_name", :name => "subject[name]")
      form.should have_selector("input#subject_major", :name => "subject[major]")
      form.should have_selector("input#subject_publish", :name => "subject[publish]")
      form.should have_selector("textarea#subject_notes", :name => "subject[notes]")
    end
  end
end
