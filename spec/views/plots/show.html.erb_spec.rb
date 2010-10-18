require 'spec_helper'

describe "plots/show.html.erb" do
  before(:each) do
    @plot = assign(:plot, stub_model(Plot,
      :item_id => 1,
      :place_id => 1,
      :notes => "MyText",
      :publish => false,
      :position => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    rendered.should contain(1.to_s)
    rendered.should contain(1.to_s)
    rendered.should contain("MyText".to_s)
    rendered.should contain(false.to_s)
    rendered.should contain(1.to_s)
  end
end
