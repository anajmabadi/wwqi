require 'spec_helper'

describe "eras/index.html.erb" do
  before(:each) do
    assign(:eras, [
      stub_model(Era,
        :title => "Title",
        :year => 1,
        :publish => false
      ),
      stub_model(Era,
        :title => "Title",
        :year => 1,
        :publish => false
      )
    ])
  end

  it "renders a list of eras" do
    render
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat-matchers flag if you want to use webrat matchers
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
