require 'spec_helper'

describe "classifications/show.html.erb" do
  before(:each) do
    assign(:classification, @classification = stub_model(Classification,
      :subject_id => 1,
      :item_id => 1,
      :publish => false,
      :position => 1,
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
  end
end
