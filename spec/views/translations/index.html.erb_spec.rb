require 'spec_helper'

describe "translations/index.html.erb" do
  before(:each) do
    assign(:translations, [
      stub_model(Translation,
        :locale => "MyString",
        :key => "MyString",
        :value => "MyText",
        :interpolations => "MyText",
        :is_proc => false
      ),
      stub_model(Translation,
        :locale => "MyString",
        :key => "MyString",
        :value => "MyText",
        :interpolations => "MyText",
        :is_proc => false
      )
    ])
  end

  it "renders a list of translations" do
    render
    response.should have_selector("tr>td", :content => "MyString".to_s, :count => 2)
    response.should have_selector("tr>td", :content => "MyString".to_s, :count => 2)
    response.should have_selector("tr>td", :content => "MyText".to_s, :count => 2)
    response.should have_selector("tr>td", :content => "MyText".to_s, :count => 2)
    response.should have_selector("tr>td", :content => false.to_s, :count => 2)
  end
end
