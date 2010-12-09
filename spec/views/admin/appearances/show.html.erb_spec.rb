require 'spec_helper'

describe "appearances/show.html.erb" do
  before(:each) do
    assign(:appearance, @appearance = stub_model(Appearance,
      :item_id => 1,
      :person_id => 1,
      :publish => false,
      :position => 1,
      :caption => "MyText",
      :notes => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    response.should contain(1)
    response.should contain(1)
    response.should contain(false)
    response.should contain(1)
    response.should contain("MyText")
    response.should contain("MyText")
  end
end
