require 'spec_helper'

describe "comps/index.html.erb" do
  before(:each) do
    assign(:comps, [
      stub_model(Comp,
        :item_id => 1,
        :comps_id => 1,
        :position => 1,
        :publish => false,
        :notes => "Notes"
      ),
      stub_model(Comp,
        :item_id => 1,
        :comps_id => 1,
        :position => 1,
        :publish => false,
        :notes => "Notes"
      )
    ])
  end

  it "renders a list of comps" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
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
