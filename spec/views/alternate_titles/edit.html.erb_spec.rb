require 'spec_helper'

describe "alternate_titles/edit.html.erb" do
  before(:each) do
    @alternate_title = assign(:alternate_title, stub_model(AlternateTitle,
      :name => "MyString",
      :caption => "MyText",
      :publish => false,
      :notes => "MyString"
    ))
  end

  it "renders the edit alternate_title form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => alternate_title_path(@alternate_title), :method => "post" do
      assert_select "input#alternate_title_name", :name => "alternate_title[name]"
      assert_select "textarea#alternate_title_caption", :name => "alternate_title[caption]"
      assert_select "input#alternate_title_publish", :name => "alternate_title[publish]"
      assert_select "input#alternate_title_notes", :name => "alternate_title[notes]"
    end
  end
end
