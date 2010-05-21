require 'spec_helper'

describe "classifications/index.html.erb" do
  before(:each) do
    assign(:classifications, [
      stub_model(Classification,
        :subject_id => 1,
        :item_id => 1,
        :publish => false,
        :position => 1,
        :notes => "MyText"
      ),
      stub_model(Classification,
        :subject_id => 1,
        :item_id => 1,
        :publish => false,
        :position => 1,
        :notes => "MyText"
      )
    ])
  end

  it "renders a list of classifications" do
    render
    response.should have_selector("tr>td", :content => 1.to_s, :count => 2)
    response.should have_selector("tr>td", :content => 1.to_s, :count => 2)
    response.should have_selector("tr>td", :content => false.to_s, :count => 2)
    response.should have_selector("tr>td", :content => 1.to_s, :count => 2)
    response.should have_selector("tr>td", :content => "MyText".to_s, :count => 2)
  end
end
