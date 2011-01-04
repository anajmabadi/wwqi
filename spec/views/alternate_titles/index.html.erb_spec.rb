require 'spec_helper'

describe "alternate_titles/index.html.erb" do
  before(:each) do
    assign(:alternate_titles, [
      stub_model(AlternateTitle,
        :name => "Name",
        :caption => "MyText",
        :publish => false,
        :notes => "Notes"
      ),
      stub_model(AlternateTitle,
        :name => "Name",
        :caption => "MyText",
        :publish => false,
        :notes => "Notes"
      )
    ])
  end

  it "renders a list of alternate_titles" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => false.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Notes".to_s, :count => 2
  end
end
