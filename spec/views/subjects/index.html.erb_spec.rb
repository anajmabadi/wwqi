require 'spec_helper'

describe "subjects/index.html.erb" do
  before(:each) do
    assign(:subjects, [
      stub_model(Subject,
        :name => "MyString",
        :major => false,
        :publish => false,
        :notes => "MyText"
      ),
      stub_model(Subject,
        :name => "MyString",
        :major => false,
        :publish => false,
        :notes => "MyText"
      )
    ])
  end

  it "renders a list of subjects" do
    render
    response.should have_selector("tr>td", :content => "MyString".to_s, :count => 2)
    response.should have_selector("tr>td", :content => false.to_s, :count => 2)
    response.should have_selector("tr>td", :content => false.to_s, :count => 2)
    response.should have_selector("tr>td", :content => "MyText".to_s, :count => 2)
  end
end
