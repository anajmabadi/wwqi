require 'spec_helper'

describe "months/edit.html.erb" do
  before(:each) do
    @month = assign(:month, stub_model(Month,
      :name => "MyString",
      :calendar_type_id => 1,
      :position => 1,
      :pubish => false,
      :notes => "MyString"
    ))
  end

  it "renders the edit month form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => month_path(@month), :method => "post" do
      assert_select "input#month_name", :name => "month[name]"
      assert_select "input#month_calendar_type_id", :name => "month[calendar_type_id]"
      assert_select "input#month_position", :name => "month[position]"
      assert_select "input#month_pubish", :name => "month[pubish]"
      assert_select "input#month_notes", :name => "month[notes]"
    end
  end
end
