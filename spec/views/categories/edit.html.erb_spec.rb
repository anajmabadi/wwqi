require 'spec_helper'

describe "categories/edit.html.erb" do
  before(:each) do
    assign(:category, @category = stub_model(Category,
      :new_record? => false,
      :name => "MyString",
      :description => "MyText",
      :position => 1,
      :publish => false,
      :notes => "MyText"
    ))
  end

  it "renders the edit category form" do
    render

    response.should have_selector("form", :action => category_path(@category), :method => "post") do |form|
      form.should have_selector("input#category_name", :name => "category[name]")
      form.should have_selector("textarea#category_description", :name => "category[description]")
      form.should have_selector("input#category_position", :name => "category[position]")
      form.should have_selector("input#category_publish", :name => "category[publish]")
      form.should have_selector("textarea#category_notes", :name => "category[notes]")
    end
  end
end
