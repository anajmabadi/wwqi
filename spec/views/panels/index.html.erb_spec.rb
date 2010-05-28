require 'spec_helper'

describe "panels/index.html.erb" do
  before(:each) do
    assign(:panels, [
      stub_model(Panel,
        :exhibition_id => 1,
        :item_id => 1,
        :position => 1,
        :publish => false,
        :caption => "MyText",
        :notes => "MyText"
      ),
      stub_model(Panel,
        :exhibition_id => 1,
        :item_id => 1,
        :position => 1,
        :publish => false,
        :caption => "MyText",
        :notes => "MyText"
      )
    ])
  end

  it "renders a list of panels" do
    render
    response.should have_selector("tr>td", :content => 1.to_s, :count => 2)
    response.should have_selector("tr>td", :content => 1.to_s, :count => 2)
    response.should have_selector("tr>td", :content => 1.to_s, :count => 2)
    response.should have_selector("tr>td", :content => false.to_s, :count => 2)
    response.should have_selector("tr>td", :content => "MyText".to_s, :count => 2)
    response.should have_selector("tr>td", :content => "MyText".to_s, :count => 2)
  end
end
