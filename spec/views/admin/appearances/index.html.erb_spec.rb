require 'spec_helper'

describe "appearances/index.html.erb" do
  before(:each) do
    assign(:appearances, [
      stub_model(Appearance,
        :item_id => 1,
        :person_id => 1,
        :publish => false,
        :position => 1,
        :caption => "MyText",
        :notes => "MyText"
      ),
      stub_model(Appearance,
        :item_id => 1,
        :person_id => 1,
        :publish => false,
        :position => 1,
        :caption => "MyText",
        :notes => "MyText"
      )
    ])
  end

  it "renders a list of appearances" do
    render
    response.should have_selector("tr>td", :content => 1.to_s, :count => 2)
    response.should have_selector("tr>td", :content => 1.to_s, :count => 2)
    response.should have_selector("tr>td", :content => false.to_s, :count => 2)
    response.should have_selector("tr>td", :content => 1.to_s, :count => 2)
    response.should have_selector("tr>td", :content => "MyText".to_s, :count => 2)
    response.should have_selector("tr>td", :content => "MyText".to_s, :count => 2)
  end
end
