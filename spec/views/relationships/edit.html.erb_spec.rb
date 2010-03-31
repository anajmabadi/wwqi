require 'spec_helper'

describe "relationships/edit.html.erb" do
  before(:each) do
    assign(:relationship, @relationship = stub_model(Relationship,
      :new_record? => false,
      :name => "MyString",
      :description => "MyText",
      :position => 1,
      :publish => false,
      :notes => "MyText"
    ))
  end

  it "renders the edit relationship form" do
    render

    response.should have_selector("form", :action => relationship_path(@relationship), :method => "post") do |form|
      form.should have_selector("input#relationship_name", :name => "relationship[name]")
      form.should have_selector("textarea#relationship_description", :name => "relationship[description]")
      form.should have_selector("input#relationship_position", :name => "relationship[position]")
      form.should have_selector("input#relationship_publish", :name => "relationship[publish]")
      form.should have_selector("textarea#relationship_notes", :name => "relationship[notes]")
    end
  end
end
