require 'spec_helper'

describe "clip_types/index.html.erb" do
  before(:each) do
    assign(:clip_types, [
      stub_model(ClipType,
        :name => "MyString",
        :extension => "MyString",
        :publish => false,
        :notes => "MyText"
      ),
      stub_model(ClipType,
        :name => "MyString",
        :extension => "MyString",
        :publish => false,
        :notes => "MyText"
      )
    ])
  end

  it "renders a list of clip_types" do
    render
    response.should have_selector("tr>td", :content => "MyString".to_s, :count => 2)
    response.should have_selector("tr>td", :content => "MyString".to_s, :count => 2)
    response.should have_selector("tr>td", :content => false.to_s, :count => 2)
    response.should have_selector("tr>td", :content => "MyText".to_s, :count => 2)
  end
end
