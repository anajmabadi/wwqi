require 'spec_helper'

describe "images/edit.html.erb" do
  before(:each) do
    assign(:image, @image = stub_model(Image,
      :new_record? => false,
      :title => "MyString",
      :description => "MyString",
      :dimensions => "MyString",
      :verso => false,
      :position => 1,
      :notes => "MyText",
      :publish => false
    ))
  end

  it "renders the edit image form" do
    render

    response.should have_selector("form", :action => admin_image_path(@image), :method => "post") do |form|
      form.should have_selector("input#image_title", :name => "image[title]")
      form.should have_selector("input#image_description", :name => "image[description]")
      form.should have_selector("input#image_dimensions", :name => "image[dimensions]")
      form.should have_selector("input#image_verso", :name => "image[verso]")
      form.should have_selector("input#image_position", :name => "image[position]")
      form.should have_selector("textarea#image_notes", :name => "image[notes]")
      form.should have_selector("input#image_publish", :name => "image[publish]")
    end
  end
end
