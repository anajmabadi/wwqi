require 'spec_helper'

describe "months/new.html.erb" do
  before(:each) do
    assign(:month, stub_model(Month,
      :name => "MyString",
      :calendar_type_id => 1,
      :position => 1,
      :pubish => false,
      :notes => "MyString"
    ).as_new_record)
  end

  it "renders new month form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => months_path, :method => "post" do
      assert_select "input#month_name", :name => "month[name]"
      assert_select "input#month_calendar_type_id", :name => "month[calendar_type_id]"
      assert_select "input#month_position", :name => "month[position]"
      assert_select "input#month_pubish", :name => "month[pubish]"
      assert_select "input#month_notes", :name => "month[notes]"
    end
  end
end
