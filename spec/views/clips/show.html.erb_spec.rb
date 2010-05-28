require 'spec_helper'

describe "clips/show.html.erb" do
  before(:each) do
    assign(:clip, @clip = stub_model(Clip,
      :title => "MyString",
      :caption => "MyText",
      :item_id => 1,
      :clip_type_id => 1,
      :publish => false,
      :notes => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    response.should contain("MyString")
    response.should contain("MyText")
    response.should contain(1)
    response.should contain(1)
    response.should contain(false)
    response.should contain("MyText")
  end
end
