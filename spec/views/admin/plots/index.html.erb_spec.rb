require 'spec_helper'

describe "plots/index.html.erb" do
  before(:each) do
    assign(:plots, [
      stub_model(Plot,
        :item_id => 1,
        :place_id => 1,
        :notes => "MyText",
        :publish => false,
        :position => 1
      ),
      stub_model(Plot,
        :item_id => 1,
        :place_id => 1,
        :notes => "MyText",
        :publish => false,
        :position => 1
      )
    ])
  end

  it "renders a list of plots" do
    render
    rendered.should have_selector("tr>td", :content => 1.to_s, :count => 2)
    rendered.should have_selector("tr>td", :content => 1.to_s, :count => 2)
    rendered.should have_selector("tr>td", :content => "MyText".to_s, :count => 2)
    rendered.should have_selector("tr>td", :content => false.to_s, :count => 2)
    rendered.should have_selector("tr>td", :content => 1.to_s, :count => 2)
  end
end
