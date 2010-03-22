require 'spec_helper'

describe "categorizations/index.html.erb" do
  before(:each) do
    assign(:categorizations, [
      stub_model(Categorization,
        :category_id => 1,
        :item_id => 1
      ),
      stub_model(Categorization,
        :category_id => 1,
        :item_id => 1
      )
    ])
  end

  it "renders a list of categorizations" do
    render
    response.should have_selector("tr>td", :content => 1.to_s, :count => 2)
    response.should have_selector("tr>td", :content => 1.to_s, :count => 2)
  end
end
