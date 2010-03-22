require 'spec_helper'

describe "categorizations/show.html.erb" do
  before(:each) do
    assign(:categorization, @categorization = stub_model(Categorization,
      :category_id => 1,
      :item_id => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    response.should contain(1)
    response.should contain(1)
  end
end
