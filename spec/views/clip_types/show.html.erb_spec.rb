require 'spec_helper'

describe "clip_types/show.html.erb" do
  before(:each) do
    assign(:clip_type, @clip_type = stub_model(ClipType,
      :name => "MyString",
      :extension => "MyString",
      :publish => false,
      :notes => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    response.should contain("MyString")
    response.should contain("MyString")
    response.should contain(false)
    response.should contain("MyText")
  end
end
