require 'spec_helper'

describe "pages/edit.html.erb" do
  before(:each) do
    assign(:page, @page = stub_model(Page,
      :new_record? => false,
      :title => "MyString",
      :caption => "MyText",
      :body => "MyText",
      :publish => false,
      :notes => "MyText"
    ))
  end

  it "renders the edit page form" do
    render

    response.should have_selector("form", :action => page_path(@page), :method => "post") do |form|
      form.should have_selector("input#page_title", :name => "page[title]")
      form.should have_selector("textarea#page_caption", :name => "page[caption]")
      form.should have_selector("textarea#page_body", :name => "page[body]")
      form.should have_selector("input#page_publish", :name => "page[publish]")
      form.should have_selector("textarea#page_notes", :name => "page[notes]")
    end
  end
end
