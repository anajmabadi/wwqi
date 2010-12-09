require 'spec_helper'

describe "sections/new.html.erb" do
  before(:each) do
    assign(:section, stub_model(Section,
      :title => "MyString",
      :caption => "MyText",
      :start_page => 1,
      :start_page_label => "MyString",
      :end_page => 1,
      :end_page_label => "MyString",
      :parent_id => 1,
      :publish => false,
      :notes => "MyString"
    ).as_new_record)
  end

  it "renders new section form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => sections_path, :method => "post" do
      assert_select "input#section_title", :name => "section[title]"
      assert_select "textarea#section_caption", :name => "section[caption]"
      assert_select "input#section_start_page", :name => "section[start_page]"
      assert_select "input#section_start_page_label", :name => "section[start_page_label]"
      assert_select "input#section_end_page", :name => "section[end_page]"
      assert_select "input#section_end_page_label", :name => "section[end_page_label]"
      assert_select "input#section_parent_id", :name => "section[parent_id]"
      assert_select "input#section_publish", :name => "section[publish]"
      assert_select "input#section_notes", :name => "section[notes]"
    end
  end
end
