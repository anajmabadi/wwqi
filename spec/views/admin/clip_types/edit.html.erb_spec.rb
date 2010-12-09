require 'spec_helper'

describe "clip_types/edit.html.erb" do
  before(:each) do
    assign(:clip_type, @clip_type = stub_model(ClipType,
      :new_record? => false,
      :name => "MyString",
      :extension => "MyString",
      :publish => false,
      :notes => "MyText"
    ))
  end

  it "renders the edit clip_type form" do
    render

    response.should have_selector("form", :action => admin_clip_type_path(@clip_type), :method => "post") do |form|
      form.should have_selector("input#clip_type_name", :name => "clip_type[name]")
      form.should have_selector("input#clip_type_extension", :name => "clip_type[extension]")
      form.should have_selector("input#clip_type_publish", :name => "clip_type[publish]")
      form.should have_selector("textarea#clip_type_notes", :name => "clip_type[notes]")
    end
  end
end
