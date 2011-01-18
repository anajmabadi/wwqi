require 'spec_helper'

describe "months/index.html.erb" do
  before(:each) do
    assign(:months, [
      stub_model(Month,
        :name => "Name",
        :calendar_type_id => 1,
        :position => 1,
        :pubish => false,
        :notes => "Notes"
      ),
      stub_model(Month,
        :name => "Name",
        :calendar_type_id => 1,
        :position => 1,
        :pubish => false,
        :notes => "Notes"
      )
    ])
  end

  it "renders a list of months" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => false.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Notes".to_s, :count => 2
  end
end
