require 'spec_helper'

describe "panels/show.html.erb" do
  before(:each) do
    assign(:panel, @panel = stub_model(Panel,
      :exhibition_id => 1,
      :item_id => 1,
      :position => 1,
      :publish => false,
      :caption => "MyText",
      :notes => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    response.should contain(1)
    response.should contain(1)
    response.should contain(1)
    response.should contain(false)
    response.should contain("MyText")
    response.should contain("MyText")
  end
end
