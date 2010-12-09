require 'spec_helper'

describe "admin/sections/index.html.erb" do
  before(:each) do
    assign(:sections, [
      stub_model(Section,
        :item_id => 1,
        :title => "Title",
        :caption => "MyText",
        :start_page => 1,
        :start_page_label => "Start Page Label",
        :end_page => 1,
        :end_page_label => "End Page Label",
        :parent_id => 1,
        :publish => false,
        :notes => "Notes"
      ),
      stub_model(Section,
        :item_id => 1,
        :title => "Title",
        :caption => "MyText",
        :start_page => 2,
        :start_page_label => "Start Page Label",
        :end_page => 2,
        :end_page_label => "End Page Label",
        :parent_id => 1,
        :publish => false,
        :notes => "Notes"
      )
    ])
  end

  it "renders a list of sections" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 6
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Start Page Label".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "End Page Label".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 2.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Notes".to_s, :count => 2
  end
end
